// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/features/constants/url_constant.dart';
import 'package:go_shop/features/helper_function/db_helper.dart';
import 'package:go_shop/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  static
  RxList<UserModel> User = <UserModel>[].obs;
  final authService = AuthStorage();
  var firstname = ''.obs;
  var lastname = ''.obs;
  var email = ''.obs;
  var username = ''.obs;
  var userId = RxnInt();

  Future<void> fetchUserId() async {
    final dbquery = await authService.getAuthData();
    if (dbquery != null && dbquery['userId'] != null) {
      userId.value = dbquery['userId'];
    } else {
      userId.value = null;
    }
  }

  Future<void> fetchUser() async {
    try {
      final dbquery = await authService.getAuthData();
      if (dbquery != null) {
        final userId = dbquery['userId'].toString();
        final uri = Uri.parse('${UrlConstant.url}users/getuser/$userId');
        final response = await http.get(uri);
        if (response.statusCode == 201 || response.statusCode == 200) {
          final Map<String, dynamic> user = jsonDecode(response.body);
          final Map<String, dynamic> userData = user['user'];
          final loadedUser = UserModel.fromMap(userData);
          User.assignAll([loadedUser]);
          firstname.value = userData['firstName'];
          lastname.value = userData['lastName'];
          email.value = userData['email'];
          username.value = userData['username'];
        }
      } else {}
    } catch (e) {
      debugPrint('Failed to load users: $e');
    }
  }
}
