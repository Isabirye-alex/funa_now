import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class PaymentController extends GetxController {
  static PaymentController get to => Get.find();
  // List of available payment methods
  var paymentMethods = <String>[].obs;

  // Currently selected payment method
  var selectedMethod = ''.obs;

  // Loading state
  var isLoading = false.obs;

  // Error message
  var error = ''.obs;

  /// Fetch payment methods from backend
  Future<void> fetchPaymentMethods() async {
    isLoading.value = true;
    error.value = '';

    try {
      final response = await http.get(
        Uri.parse('http://10.39.3.14:3000/payments/paymentmethods'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        debugPrint('$data');
        paymentMethods.value = List<String>.from(data['paymentMethods']);
        if (paymentMethods.isNotEmpty) {
          selectedMethod.value = paymentMethods.first;
        }
      } else {
        error.value = 'Failed to fetch payment methods.';
      }
    } catch (e) {
      error.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  /// Set selected payment method
  void selectMethod(String method) {
    selectedMethod.value = method;
  }
}
