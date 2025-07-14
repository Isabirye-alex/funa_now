// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/features/constants/url_constant.dart';
import 'package:go_shop/models/products_model.dart';
import 'package:http/http.dart' as http;

class ProductsController extends GetxController {
  final RxList<ProductsModel> products = <ProductsModel>[].obs;
  final RxBool isLoading = true.obs;

  Future<void> fetchProducts(BuildContext context) async {
    try {
      isLoading.value = true;
      final uri = Uri.parse('${UrlConstant.url}products');
      final response = await http.get(uri);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> result = jsonDecode(response.body);

        if (result['data'] == null || result['data'] is! List) {
          debugPrint('Unkown error occured');
          return;
        }

        final List<dynamic> jsonList = result['data'];
        final List<ProductsModel> loadedProducts = jsonList
            .map((e) => ProductsModel.fromMap(e))
            .toList();

        products.assignAll(loadedProducts);
        debugPrint('Products fetched successfully');
      } else {
        showFlushbar(
          context,
          'Error',
          'Failed to load products (${response.statusCode})',
          Icons.warning,
        );
      }
    } catch (e) {
      debugPrint('Fetch error: $e');
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
