// ignore_for_file: use_build_context_synchronously, unnecessary_string_interpolations

import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/controllers/user_controller.dart';
import 'package:go_shop/features/constants/url_constant.dart';
import 'package:go_shop/features/helper_function/db_helper.dart';
import 'package:go_shop/models/order_email_model.dart';
import 'package:go_shop/models/order_item_model.dart';
import 'package:go_shop/models/order_model.dart';
import 'package:go_shop/ui/pages/stand_alone/order_list_page.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find();
  final cartController = Get.put(CartController());
  final RxList<OrderModel> order = <OrderModel>[].obs;
  final RxnInt userId = RxnInt(); // Reactive user ID
  final authService = AuthStorage();
  var orderId = RxnString();
  var isLoading = true.obs;
  var isPlacingOrder = false.obs;
  final RxList<OrderItemModel> orderItem = <OrderItemModel>[].obs;
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

  Future<bool> checkUserLoggedIn(BuildContext context) async {
    await loadUserId();
    if (userId.value == null) {
      Flushbar(
        title: 'Not Logged In',
        message: 'Please log in to view your orders and start shopping.',
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.orange,
        icon: const Icon(Icons.info, color: Colors.white),
      ).show(context);
      return false;
    }
    return true;
  }

  Future<void> fetchUserOrders() async {
    if (userId.value == null) return;

    try {
      final response = await http.get(
        Uri.parse('${UrlConstant.url}orders/user/${userId.value}'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        final List<dynamic> jsonList = result['data'];
        final List<OrderModel> res = jsonList
            .map((e) => OrderModel.fromMap(e))
            .toList();
        order.assignAll(res);
      } else {}
    } catch (e) {
      debugPrint('Error fetching user orders: $e');
    }
  }

  Future<void> getOrderItems(int orderId) async {
    debugPrint('Entered Get order items function');
    try {
      final response = await http.get(
        Uri.parse('${UrlConstant.url}orders/orderitems/$orderId'),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        final List<dynamic> jsonList = res['data'];
        final List<OrderItemModel> result = jsonList
            .map((e) => OrderItemModel.fromJson(e))
            .toList();
        orderItem.assignAll(result);
      }
    } catch (e) {
      debugPrint('Error fetching order items : $e');
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
      return;
    }

    final items = cartController.cartItem.map((item) {
      return {
        "product_id": item.productId,
        "quantity": item.quantity,
        "price": item.price,
      };
    }).toList();

    isPlacingOrder.value = true; 

    try {
      final body = {
        "cart_id": cartId,
        "user_id": userId.value,
        "total_amount": total,
        "shipping_address": address,
        "payment_method": payment,
        "items": items,
      };

      final response = await http.post(
        Uri.parse('${UrlConstant.url}orders'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Flushbar(
          title: "Order Placed",
          message: "Thank you! Your order has been placed successfully.",
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green,
          icon: const Icon(Icons.check_circle, color: Colors.white),
        ).show(context);

        // Clear the cart to reset BottomPanel and order page UI
        cartController.clearCart();

        // Navigate and update data
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrdersListPage()),
        );

        await fetchUserOrders();

        final orderResponse = jsonDecode(response.body);
        final userController = Get.put(UserController());
        await sendOrderEmail(
          OrderEmailModel(
            receiver: userController.email.toString(),
            receiverName:
                "${userController.firstname} ${userController.lastname}",
            orderId: orderResponse['data']['order_id'],
            orderDate: DateTime.now(),
            paymentMethod: payment,
            shippingAddress: address,
            orderItems: cartController.cartItem
                .map(
                  (item) => OrderItem(
                    name: item.title,
                    quantity: item.quantity,
                    price: double.tryParse(item.price.toString()) ?? 0.0,
                    image: item.imageUrl,
                  ),
                )
                .toList(),
            total: double.tryParse(total.toString())?.toStringAsFixed(0) ?? '0',
          ),
        );

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
      Flushbar(
        title: "Error",
        message: "An unexpected error occurred. Please try again.",
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
        icon: const Icon(Icons.error, color: Colors.white),
      ).show(context);
    } finally {
      isPlacingOrder.value = false; // ✅ always reset the loading state
    }
  }

  Future<void> sendOrderEmail(OrderEmailModel model) async {
    try {
      final formattedDate = DateFormat(
        'MMMM d, y \'at\' h:mm a',
      ).format(model.orderDate);
      final body = {
        "receiver": model.receiver,
        "receiverName": model.receiverName,
        "orderId": model.orderId.toString(),
        "orderDate": formattedDate,
        "paymentMethod": model.paymentMethod,
        "shippingAddress": model.shippingAddress,
        "orderItems": model.orderItems
            .map(
              (item) => {
                "name": item.name,
                "quantity": item.quantity,
                "price": item.price,
                "image": item.image,
              },
            )
            .toList(),
        "total": model.total.toString(),
      };

      final response = await http.post(
        Uri.parse('${UrlConstant.url}email/order-placement'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {}
    } catch (e) {
      debugPrint(" Exception in sendOrderEmail(): $e");
    }
  }

  Future<void> fetchUserId() async {
    await loadUserId();
  }
}
