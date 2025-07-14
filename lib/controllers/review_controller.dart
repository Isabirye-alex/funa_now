// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/features/constants/url_constant.dart';
import 'package:go_shop/features/helper_function/db_helper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:go_shop/models/review_model.dart';

class ReviewController extends GetxController {
  RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  var isLoading = true.obs;
  final RxnInt userId = RxnInt();
  final authService = AuthStorage();
  final commentController = TextEditingController();
  var rating = RxnDouble();

  @override
  void onInit() {
    super.onInit();
    loadUserId();
  }

  Future<void> loadUserId() async {
    final dbquery = await authService.getAuthData();
    if (dbquery != null && dbquery['userId'] != null) {
      userId.value = dbquery['userId'];
      debugPrint('User ID loaded: ${userId.value}');
    } else {
      debugPrint("User ID not found");
    }
  }

  Future<bool> checkUserLoggedIn(BuildContext context) async {
    await loadUserId();
    if (userId.value == null) {
      Flushbar(
        title: 'Not Logged In',
        message: 'Please log in to view your orders and start shopping.',
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.orange,
        icon: const Icon(Icons.info, color: Colors.white),
      ).show(context);
      return false;
    }
    return true;
  }

  Future<void> postReview(String productId) async {
    await loadUserId();
    if (userId.value == null) {
      return;
    }

    try {
      final review = ReviewModel(
        user_id: userId.value.toString(),
        comment: commentController.text.trim(),
        rating: rating.value!.toDouble(),
        product_id: productId,
      );

      final res = await http.post(
        Uri.parse('${UrlConstant.url}review/postreview'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(review.toJson()),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        await getReviews();
        update();
        final response = jsonDecode(res.body);
        debugPrint('$response');
      } else {
        debugPrint('Un known error occured!');
      }
    } catch (e) {
      debugPrint('Error occurred while posting a reviews: $e');
    }
  }

  Future<void> getReviews() async {
    try {
      final res = await http.get(
        Uri.parse('${UrlConstant.url}review/getreviews/${userId.value}'),
      );
      if (res.statusCode == 201 || res.statusCode == 200) {
        // ignore: unnecessary_string_interpolations
        debugPrint('${res.body}');
        final Map<String, dynamic> response = jsonDecode(res.body);
        final List<dynamic> jsonList = response['data'];
        final List<ReviewModel> finalResult = jsonList
            .map((r) => ReviewModel.fromJson(r))
            .toList();
        reviews.assignAll(finalResult);
      } else {
        debugPrint('Failed to post review');
      }
    } catch (e) {
      debugPrint('Error occurred while fetching product reviews: $e');
    }
  }

  Future<void> updateReview(double rating, String productId) async {
    await loadUserId();
    if (userId.value == null) {
      return;
    }
    try {
      final review = ReviewModel(
        user_id: userId.value.toString(),
        comment: commentController.text.trim(),
        rating: rating,
        product_id: productId,
      );

      final res = await http.patch(
        Uri.parse('${UrlConstant.url}review/updatereview/${userId.value}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(review.toJson()),
      );
      if (res.statusCode == 201 || res.statusCode == 200) {
        final response = jsonDecode(res.body);
        await getReviews();
        debugPrint('$response');
      }
    } catch (e) {
      debugPrint('Error updating review: $e');
    }
  }
}
