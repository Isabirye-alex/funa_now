// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/controllers/order_controller.dart';
import 'package:go_shop/controllers/wishlist_controller.dart';
import 'package:go_shop/features/constants/url_constant.dart';
import 'package:go_shop/features/helper_function/db_helper.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final loginformKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  var isLoading = false.obs;
  var isPasswordHidden = true.obs;
  final authService = AuthStorage();
  var userId = ''.obs;

  Future<void> login(BuildContext context) async {
    isLoading.value = true;
    try {
      final uri = Uri.parse('${UrlConstant.url}users/login');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': usernameController.text.trim(),
          'password': passwordController.text.trim(),
        }),
      );

      isLoading.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(response.body);
        userId.value = result['user']['id'].toString();
        await authService.saveAuthData('', int.parse(userId.value));
        // Show flushbar without await:
        Flushbar(
          shouldIconPulse: false,
          borderRadius: BorderRadius.circular(8),
          margin: EdgeInsets.all(24),
          flushbarPosition: FlushbarPosition.TOP,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.green,
          messageText: Text(
            'Success',
            style: const TextStyle(color: Colors.white),
          ),
          duration: const Duration(seconds: 4),
          icon: Icon(Icons.check_circle, color: Colors.white),
          titleText: Text(
            'Log in successful',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ).show(context);
        usernameController.clear();
        passwordController.clear();
        final orderController = Get.put(OrderController());
        await orderController.loadUserId();
        await orderController.fetchUserOrders();

        // Small delay before navigating:
        Future.delayed(Duration(milliseconds: 300), () {
          GoRouter.of(context).go('/landingpage');
        });

        GoRouter.of(context).go('/landingpage');
        final token = result['token'];
        debugPrint('Token: $token');
      } else {
        _showError(context, 'Login failed: Invalid user name or password');
      }
    } catch (e) {
      isLoading.value = false;
      _showError(context, 'Something Went Wrong. Please try again later');
    }
  }

  void _showError(BuildContext context, String message) {
    Flushbar(
      shouldIconPulse: false,
      borderRadius: BorderRadius.circular(8),
      margin: EdgeInsets.all(24),
      flushbarPosition: FlushbarPosition.TOP,
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.red,
      messageText: Text('Error', style: const TextStyle(color: Colors.white)),
      duration: const Duration(seconds: 4),
      icon: Icon(Icons.error, color: Colors.white),
      titleText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ).show(context);
  }

  Future<void> logout(BuildContext context) async {
    await authService.clearAuthData();

    // Clear order and user data
    final orderController = Get.find<OrderController>();
    final wishlistController = Get.find<WishlistController>();
    orderController.order.clear();
    orderController.orderItem.clear();
    orderController.userId.value = null;
    wishlistController.wishlist.clear();
    wishlistController.userId.value = null;

    GoRouter.of(context).go('/landingpage');

    await Flushbar(
      shouldIconPulse: false,
      borderRadius: BorderRadius.circular(8),
      margin: EdgeInsets.all(24),
      flushbarPosition: FlushbarPosition.TOP,
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.green,
      messageText: Text('Success', style: const TextStyle(color: Colors.white)),
      duration: const Duration(seconds: 4),
      icon: Icon(Icons.check_circle, color: Colors.white),
      titleText: Text(
        'Log out successful',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ).show(context);
  }
}
