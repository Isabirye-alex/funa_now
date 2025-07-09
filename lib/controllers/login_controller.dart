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
    try {
      final uri = Uri.parse('http://192.168.100.57/users/login');
      final response = await http.post(
        uri,
        body: jsonEncode(<String, String>{
          'username': usernameController.text.trim(),
          'password': passwordController.text.trim(),
        },
      ));
      if (response.statusCode == 201 || response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final token = result.token;

      }
    } catch (e) {
      Flushbar(
        shouldIconPulse: false,
        borderRadius: BorderRadius.circular(8),
        margin: EdgeInsets.all(24),
        flushbarPosition: FlushbarPosition.TOP,
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.green,
        messageText: Text('Error', style: const TextStyle(color: Colors.white)),
        duration: const Duration(seconds: 4),
        icon: Icon(Icons.check_circle, color: Colors.white),
        titleText: Text(
          'Cross check details and try again $e',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ).show(context);
    }
  }
}
