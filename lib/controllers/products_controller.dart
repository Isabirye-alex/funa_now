import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:go_shop/models/products_model.dart';

class ProductsController extends GetxController {
  final RxList<ProductsModel> products = <ProductsModel>[].obs;
  final RxBool isLoading = true.obs;


  Future<void> fetchProducts(BuildContext context) async {
    try {
      isLoading.value = true;
      final uri = Uri.parse('http://192.168.1.7:3000/products');
      final response = await http.get(uri);
      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        print('Parsed JSON: $result');

        if (result['data'] == null || result['data'] is! List) {
          showFlushbar(
            context,
            'Error',
            'Invalid response: missing "data" array',
            Icons.error,
          );
          return;
        }

        final List<dynamic> jsonList = result['data'];
        final List<ProductsModel> loadedProducts = jsonList
            .map((e) => ProductsModel.fromJson(e))
            .toList();

        products.assignAll(loadedProducts);
        showFlushbar(
          context,
          'Success',
          'Products successfully fetched',
          Icons.check_circle,
        );
      } else {
        showFlushbar(
          context,
          'Error',
          'Failed to load products (${response.statusCode})',
          Icons.warning,
        );
      }
    } catch (e) {
      print('Fetch error: $e');
      showFlushbar(
        context,
        'Error',
        'Network or parsing error: $e',
        Icons.error,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void showFlushbar(
    BuildContext context,
    String title,
    String message,
    IconData icon,
  ) {
    Flushbar(
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: const Color(0xFF323232),
      messageText: Text(message, style: const TextStyle(color: Colors.white)),
      duration: const Duration(seconds: 4),
      icon: Icon(icon, color: Colors.white),
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ).show(context);
  }
}
