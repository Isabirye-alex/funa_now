import 'dart:convert';

import 'package:get/get.dart';
import 'package:go_shop/features/helper_function/db_helper.dart';
import 'package:go_shop/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddressController extends GetxController {
  final authService = AuthStorage();
  RxList<AddressModel> address = <AddressModel>[].obs;
  var userId = RxnInt();
  final addresslineController = TextEditingController();
  final districtController = TextEditingController();
  final regionController = TextEditingController();
  final postalcodeController = TextEditingController();
  final countryController = TextEditingController();

  Future<void> addNewAddress() async {
    final dbquery = await authService.getAuthData();
    if (dbquery != null && dbquery['userId'] != null) {
      userId.value = dbquery['userId'];
      try {
        final address = AddressModel(
          user_id: userId.value.toString(),
          address_line: addresslineController.text.trim(),
          district: districtController.text.trim(),
          postal_code: postalcodeController.text.trim(),
          region: regionController.text.trim(),
        );
        final response = await http.post(
          Uri.parse('http://192.168.100.57:3000/addadress'),
          headers: {'Content-Type': 'application/json'},
          body: (address.toJson()),
        );
        if (response.statusCode == 201 || response.statusCode == 200) {
          final result = jsonDecode(response.body);
          debugPrint('$result');
        }
      } catch (e) {
        debugPrint('Could not add address: $e');
      }
    } else {
      userId.value = null;
    }
  }

  Future<void> fetchUserId() async {
    final dbquery = await authService.getAuthData();
    if (dbquery != null && dbquery['userId'] != null) {
      userId.value = dbquery['userId'];
    } else {
      userId.value = null;
    }
  }
}
