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
  static ReviewController get to => Get.find();
  RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  var isLoading = true.obs;
  final RxnInt userId = RxnInt();
  final authService = AuthStorage();
  final commentController = TextEditingController();
  var rating = RxnDouble();
  Map<int, int> ratingCounts = {};
  RxInt totalRatings = 0.obs;
  double get averageRating {
    if (totalRatings.value == 0) return 0;
    double sum = 0;
    ratingCounts.forEach((star, count) {
      sum += star * count;
    });
    return sum / totalRatings.value;
  }

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

  Future<void> postReview(int productId) async {
    await loadUserId();
    if (userId.value == null) {
      return;
    }

    try {
      final review = ReviewModel(
        user_id: userId.value!,
        comment: commentController.text.trim(),

        rating: rating.value!.toDouble(),
        product_id: productId,
      );

      if (rating.value == null || commentController.text.trim().isEmpty) {
        Flushbar(
          title: 'Incomplete Review',
          message: 'Please provide a rating and a comment before submitting.',
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.warning, color: Colors.white),
        ).show(Get.context!); // or context
        return;
      }

      final res = await http.post(
        Uri.parse('${UrlConstant.url}review/postreview/${userId.value}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(review.toMap()),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        await getReviews();
        update();
        final response = jsonDecode(res.body);
        debugPrint('$response');
      } else {
        debugPrint('Failed to post review: ${res.statusCode}');
        debugPrint('Response body: ${res.body}');
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

      if (res.statusCode == 200 || res.statusCode == 201) {
        final Map<String, dynamic> response = jsonDecode(res.body);
        final data = response['data'];

        // Extract counts
        final Map<String, dynamic> counts = data['ratingCounts'];
        ratingCounts = counts.map(
          (key, value) => MapEntry(int.parse(key), value),
        );
        totalRatings.value = data['totalRatings'];

        final List<dynamic> otherReviews = data['otherReviews'];
        final List<ReviewModel> finalResult = otherReviews
            .map((r) => ReviewModel.fromMap(r))
            .toList();
        reviews.assignAll(finalResult);
      } else {
        debugPrint('Failed to fetch reviews');
      }
    } catch (e) {
      debugPrint('Error fetching reviews: $e');
    }
  }

  Future<void> updateReview(double rating, int productId) async {
    await loadUserId();
    if (userId.value == null) {
      return;
    }
    try {
      final review = ReviewModel(
        user_id: userId.value!,
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
