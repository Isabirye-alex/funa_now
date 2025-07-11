// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/controllers/cart_controller.dart';
import 'package:go_shop/features/helper_function/db_helper.dart';
import 'package:go_shop/models/order_model.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  final cartController = Get.put(CartController());
  RxList<OrderModel> order = <OrderModel>[].obs;
  final authService = AuthStorage();

  Future<void> createOrder(
    BuildContext context,
    String totalAmount,
    String status,
    String shippingAddress,
    String paymentMethod,
    String username,
  ) async {
    final dbquery = await authService.getAuthData();
    if (dbquery != null && dbquery['userId'] != null) {
      try {
        final userId = dbquery['userId'];
        final orderData = OrderModel(
          user_id: userId,
          total_amount: totalAmount,
          status: status,
          shipping_address: shippingAddress,
          payment_method: paymentMethod,
          isPaid: 0,
          userName: username,
        );

        final response = await http.post(
          Uri.parse('http://192.168.100.57:3000/order'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(orderData.toJson()),
        );
        if (response.statusCode == 201 || response.statusCode == 200) {
          final result = jsonDecode(response.body);
          GoRouter.of(context).go('/orderpage');
          debugPrint('$result');
        }
      } catch (e) {
        debugPrint('Error fetching orders: $e');
      }
    } else {}
  }

  Future<void> fetchUserId() async {
    final dbquery = await authService.getAuthData();
    if (dbquery != null && dbquery['userId'] != null) {
    } else {}
  }
}
