import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/features/helper_function/db_helper.dart';
import 'package:go_shop/models/user_model.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final authStorage = AuthStorage();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isLoading = false.obs;
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  final registerformKey = GlobalKey<FormState>();
  RxList<UserModel> users = RxList<UserModel>();
  var userId = ''.obs;

  Future<void> register(BuildContext context) async {
    try {
      final uri = Uri.parse('http://10.41.3.148:3000/users/register');
      final user = UserModel(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
        imageUrl: '',
      );
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toMap()),
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      if (response.statusCode == 201 || response.statusCode == 200) {
        final result = jsonDecode(response.body);
        userId.value = result['user']['id'].toString();
        await authStorage.saveAuthData('', int.parse(userId.value));
        Navigator.pushNamed(context, '/landingpage');
        final username = result['user']['username'].toString();
        debugPrint(userId.value);
        debugPrint('User registered with username $username');
      } else {
        debugPrint('Could not register new user');
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

  //To be removed
  Future<UserModel?> fetchUserById(int userId) async {
    final uri = Uri.parse('http://10.41.3.148:3000/users/getuser/$userId');
    final response = await http.get(uri);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final result = jsonDecode(response.body);
      return UserModel.fromJson(result['user']);
    } else {
      return null;
    }
  }
}
