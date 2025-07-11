import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentController extends GetxController {
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
        Uri.parse('http://192.168.100.57:3000/paymentmethods'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
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
