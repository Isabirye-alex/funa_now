import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isLoading = false.obs;
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  final formKey = GlobalKey<FormState>();

  Future<void> register(BuildContext context) async {
    try {} catch (e) {
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
