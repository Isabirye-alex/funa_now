// ignore_for_file: use_build_context_synchronously, unnecessary_string_interpolations

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/features/helper_function/db_helper.dart';
import 'package:go_shop/models/order_model.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  final cartController = Get.put(CartController());
  final RxList<OrderModel> order = <OrderModel>[].obs;
  final RxnInt userId = RxnInt(); // Reactive user ID
  final authService = AuthStorage();

  @override
  void onInit() {
    super.onInit();
    loadUserId();
  }

  Future<void> loadUserId() async {
    final dbquery = await authService.getAuthData();
    if (dbquery != null && dbquery['userId'] != null) {
      userId.value = dbquery['userId'];
      debugPrint('User ID loaded: ${userId.value}');
    } else {
      debugPrint("User ID not found");
    }
  }

  Future<void> createOrder(
    BuildContext context,
    String totalAmount,
    String status,
    String shippingAddress,
    String paymentMethod,
    String username,
  ) async {
    if (userId.value == null) return;

    try {
      final orderData = OrderModel(
        user_id: userId.value!,
        total_amount: totalAmount,
        status: status,
        shipping_address: shippingAddress,
        payment_method: paymentMethod,
        isPaid: 0,
        userName: username,
      );

      final response = await http.post(
        Uri.parse('http://10.39.3.14:3000/order'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(orderData.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(response.body);
        debugPrint('$result');
        GoRouter.of(context).go('/orderpage');
      }
    } catch (e) {
      debugPrint('Error creating order: $e');
    }
  }

  Future<void> fetchUserOrders() async {
    if (userId.value == null) return;

    try {
      final response = await http.get(
        Uri.parse('http://10.39.3.14:3000/order/${userId.value}'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(response.body);
        debugPrint('User orders: $result');
      } else {
        debugPrint('Error response: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error fetching user orders: $e');
    }
  }

  Future<void> placeOrder(
    String cartId,
    String total,
    String address,
    String payment,
    BuildContext context,
  ) async {
    if (userId.value == null) {
      debugPrint("User ID not available.");
      return;
    }

    try {
      final items = cartController.cartItem.map((item) {
        return {
          "product_id": item.productId,
          "quantity": item.quantity,
          "price": item.price,
        };
      }).toList();

      final body = {
        "cart_id": cartId,
        "user_id": userId.value,
        "total_amount": total,
        "shipping_address": address,
        "payment_method": payment,
        "items": items,
      };

      final response = await http.post(
        Uri.parse('http://10.39.3.14:3000/orders'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Order success: ${response.body}');
        Flushbar(
          title: "Order Placed",
          message: "Thank you! Your order has been placed successfully.",
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green,
          icon: const Icon(Icons.check_circle, color: Colors.white),
        ).show(context);

        // Reload cart after order is placed
        await cartController.loadCartOnAppStart(userId.value!);
      } else {
        debugPrint('Order failed: ${response.body}');
        Flushbar(
          title: "Error",
          message: "Failed to place order. Please try again.",
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.error, color: Colors.white),
        ).show(context);
        cartController.clearCart();
      }
    } catch (e) {
      debugPrint('Exception placing order: $e');
    }
  }

  // Optional: useful if you need it somewhere else
  Future<void> fetchUserId() async {
    await loadUserId();
  }
}
