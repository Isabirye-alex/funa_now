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
  final RxList<ProductsModel> summerProducts = <ProductsModel>[].obs;
  final RxList<ProductsModel> hotSaleProducts = <ProductsModel>[].obs;
  final RxList<ProductsModel> featuredProducts = <ProductsModel>[].obs;
  final ScrollController scrollController = ScrollController();
  final RxList<ProductsModel> searchResults = <ProductsModel>[].obs;
  final RxList<ProductsModel> pro = <ProductsModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isFLoading = false.obs;
  final RxBool isHLoading = false.obs;
  final RxBool isSLoading = false.obs;
  final RxBool hasMore = true.obs;
  final RxBool isSearching = false.obs;
  int currentPage = 1;
  final int limit = 20;

  @override
  void onInit() {
    super.onInit();
    if (featuredProducts.isEmpty) getFeaturedProducts();
    if (summerProducts.isEmpty) getSummerProducts();
    if (products.isEmpty) fetchProducts();
    if (hotSaleProducts.isEmpty) getHotSaleProducts();
  }

  Future<void> fetchProducts([BuildContext? context]) async {
    if (isLoading.value || !hasMore.value) {

      return;
    }

    try {
      isLoading.value = true;

      final uri = Uri.parse(
        '${UrlConstant.url}products?page=$currentPage&limit=$limit',
      );
      final response = await http.get(uri);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(response.body);
        final List<dynamic> jsonList = result['data'];
        final List<ProductsModel> loadedProducts = jsonList
            .map((e) => ProductsModel.fromMap(e))
            .toList();

        // Check for duplicates by product ID
        final existingIds = products.map((p) => p.id).toSet();
        final newProducts = loadedProducts
            .where((p) => !existingIds.contains(p.id))
            .toList();

        if (newProducts.isEmpty) {
          hasMore.value = false; // No new data
        } else {
          products.addAll(newProducts);

          if (newProducts.length < limit) {
            hasMore.value = false; // Less than limit, no more data
          } else {
            currentPage++;
          }
        }
      } else {
        // debugPrint('Failed to load products: ${response.statusCode}');
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
      debugPrint('Error Fetching products: $e');
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

    }
  }

  void resetPagination() {
    products.clear();
    currentPage = 1;
    hasMore.value = true;
  }

  Future<void> getFeaturedProducts() async {
    try {
      isFLoading.value = true;

      final response = await http.get(
        Uri.parse('${UrlConstant.url}products/featured'),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        final List<dynamic> jsonList = res['data'];
        final List<ProductsModel> result = jsonList
            .map((f) => ProductsModel.fromMap(f))
            .toList();
        featuredProducts.assignAll(result);

      } else {

      }
    } catch (e) {
      debugPrint('Error fetching featured products: $e');
    } finally {
      isFLoading.value = false;

    }
  }

  Future<void> getSummerProducts() async {
    try {
      isSLoading.value = true;
      final response = await http.get(
        Uri.parse('${UrlConstant.url}products/summer-sale'),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        final List<dynamic> jsonList = res['data'];
        final List<ProductsModel> result = jsonList
            .map((f) => ProductsModel.fromMap(f))
            .toList();
        summerProducts.assignAll(result);
        isSLoading.value=false;
      } else {

      }
    } catch (e) {
      debugPrint('Error fetching summer products products: $e');
    } finally {
      isSLoading.value = false;
    }
  }

  Future<void> getHotSaleProducts() async {
    try {
      isHLoading.value = true;
      final response = await http.get(
        Uri.parse('${UrlConstant.url}products/hot-sale'),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        final List<dynamic> jsonList = res['data'];
        final List<ProductsModel> result = jsonList
            .map((f) => ProductsModel.fromMap(f))
            .toList();
        hotSaleProducts.assignAll(result);
        isHLoading.value = false;
      } else {

      }
    } catch (e) {
      debugPrint('Error fetching featured products: $e');
    } finally {
      isHLoading.value = false;

    }
  }


  //Search function
  Future<void> searchProducts(String query, [BuildContext? context]) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      isSearching.value = true;
      final uri = Uri.parse(
        '${UrlConstant.url}products/search?query=${Uri.encodeQueryComponent(query)}',
      );
      final response = await http.get(uri);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(response.body);
        final List<dynamic> jsonList = result['data'];
        final List<ProductsModel> results = jsonList
            .map((e) => ProductsModel.fromMap(e))
            .toList();
        searchResults.assignAll(results);
      } else {
        debugPrint('Search failed with status code: ${response.statusCode}');
        if (context != null) {
          showFlushbar(
            context,
            'Search Failed',
            'Something went wrong',
            Icons.error,
          );
        }
      }
    } catch (e) {
      debugPrint('Search error: $e');
      if (context != null) {
        showFlushbar(context, 'Error', 'Search failed: $e', Icons.error);
      }
    } finally {
      isSearching.value = false;
    }
  }

  Future<void> fetchProductsByCategoryId(int id) async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('${UrlConstant.url}products/category/$id'),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        final List<dynamic> jsonList = res['data'];
        final List<ProductsModel> result = jsonList
            .map((e) => ProductsModel.fromMap(e))
            .toList();
        pro.assignAll(result);
      } else {

      }
    } catch (e) {
      debugPrint('Error fetching products by category: $e');
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
      shouldIconPulse: false,
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
