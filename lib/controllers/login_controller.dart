// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  var isLoading = false.obs;
  bool isPasswordHidden = true;

  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      final uri = Uri.parse('http://192.168.100.57/users/login');
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
        final token = result['token'];

        // Proceed with navigation or storage
        print('Token: $token');
        Navigator.pushReplacementNamed(
          context,
          '/home',
        ); // or use Get.toNamed('/home')
      } else {
        _showError(context, 'Login failed: ${response.body}');
      }
    } catch (e) {
      isLoading.value = false;
      _showError(context, 'An error occurred: $e');
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
}



// import 'auth_storage.dart';

// Future<void> login(BuildContext context) async {
//   ...
//   if (response.statusCode == 200 || response.statusCode == 201) {
//     final result = jsonDecode(response.body);
//     final token = result['token'];
//     final userId = result['user']['id']; // depends on your API response

//     await AuthStorage().saveAuthData(token, userId);
//     print('Token and user ID saved.');

//     Get.toNamed('/home');
//   }
//   ...
// }
