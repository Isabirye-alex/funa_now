import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/features/constants/url_constant.dart';
import 'package:go_shop/models/categories_model.dart';
import 'package:http/http.dart' as http;

class CategoriesController extends GetxController {
  static CategoriesController get instance => Get.find();
  var isLoading = true.obs;
  RxList<CategoriesModel> categories = <CategoriesModel>[].obs;

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('${UrlConstant.url}categories'),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        final List<dynamic> jsonList = result['data'];
        final List<CategoriesModel> res = jsonList
            .map((c) => CategoriesModel.fromMap(c))
            .toList();
        categories.assignAll(res);

        debugPrint('Yes');
      } else {}
      isLoading.value = false;
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    }
  }
}
