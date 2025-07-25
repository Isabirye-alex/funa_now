import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/features/constants/url_constant.dart';
import 'package:go_shop/models/products_model.dart';
import 'package:http/http.dart' as http;

class ProductsController extends GetxController {
  static ProductsController get to => Get.find();

  final RxList<ProductsModel> products = <ProductsModel>[].obs;
  final RxList<ProductsModel> featuredProducts = <ProductsModel>[].obs;

  final RxBool isLoading = false.obs;
  final RxBool isFLoading = false.obs;
  final RxBool hasMore = true.obs;

  int currentPage = 1;
  final int limit = 20;

  @override
  void onInit() {
    super.onInit();
    getFeaturedProducts();
    fetchProducts();
  }

  Future<void> fetchProducts([BuildContext? context]) async {
    if (isLoading.value || !hasMore.value) {
      debugPrint('Fetch aborted: isLoading=${isLoading.value}, hasMore=${hasMore.value}');
      return;
    }

    try {
      isLoading.value = true;
      debugPrint('Fetching products for page $currentPage');

      final uri = Uri.parse('${UrlConstant.url}products?page=$currentPage&limit=$limit');
      final response = await http.get(uri);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(response.body);
        final List<dynamic> jsonList = result['data'];
        final List<ProductsModel> loadedProducts = jsonList.map((e) => ProductsModel.fromMap(e)).toList();

        // Check for duplicates by product ID
        final existingIds = products.map((p) => p.id).toSet();
        final newProducts = loadedProducts.where((p) => !existingIds.contains(p.id)).toList();

        if (newProducts.isEmpty) {
          debugPrint('No new products fetched for page $currentPage');
          hasMore.value = false; // No new data
        } else {
          products.addAll(newProducts);
          debugPrint('Added ${newProducts.length} products, total: ${products.length}');
          if (newProducts.length < limit) {
            hasMore.value = false; // Less than limit, no more data
          } else {
            currentPage++;
            debugPrint('Incremented to page $currentPage');
          }
        }
      } else {
        debugPrint('Failed to load products: ${response.statusCode}');
        if (context != null) {
          showFlushbar(
            context,
            'Error',
            'Failed to load products (${response.statusCode})',
            Icons.warning,
          );
        }
      }
    } catch (e) {
      debugPrint('Fetch error: $e');
      if (context != null) {
        showFlushbar(
          context,
          'Error',
          'Network or parsing error: $e',
          Icons.error,
        );
      }
    } finally {
      isLoading.value = false;
      debugPrint('Fetch completed, isLoading=false');
    }
  }

  void resetPagination() {
    debugPrint('Resetting pagination');
    products.clear();
    currentPage = 1;
    hasMore.value = true;
  }

  Future<void> getFeaturedProducts() async {
    try {
      isFLoading.value = true;
      debugPrint('Fetching featured products');
      final response = await http.get(Uri.parse('${UrlConstant.url}products/featured'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        final List<dynamic> jsonList = res['data'];
        final List<ProductsModel> result = jsonList.map((f) => ProductsModel.fromMap(f)).toList();
        featuredProducts.assignAll(result);
        debugPrint('Fetched ${result.length} featured products');
      } else {
        debugPrint('Failed to load featured products: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching featured products: $e');
    } finally {
      isFLoading.value = false;
      debugPrint('Featured products fetch completed, isFLoading=false');
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