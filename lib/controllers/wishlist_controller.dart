// ignore_for_file: use_build_context_synchronously

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:go_shop/features/constants/url_constant.dart';
import 'package:go_shop/features/helper_function/db_helper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:go_shop/models/wishlist_model.dart';

class WishlistController extends GetxController {
  RxList<WishlisModel> wishlist = <WishlisModel>[].obs;
  final RxnInt userId = RxnInt();
  final authService = AuthStorage();

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

  Future<void> addItemToWishList(int productId) async {
    await loadUserId();
    if (userId.value == null) {
      return;
    }

    try {
      final wishlist = WishlisModel(
        product_id: productId.toString(),
        user_id: userId.toString(),
      );
      final response = await http.post(
        Uri.parse('${UrlConstant}wishlist/additem'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(wishlist.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(response.body);
        debugPrint('$result');
      } else {
        debugPrint('Unknown error occurred');
      }
    } catch (e) {
      debugPrint('Error adding item to wishlist: $e');
    }
  }

  Future<void> getWishListItems() async {
    await loadUserId();
    if (userId.value == null) {
      return;
    }
    try {
      final response = await http.get(
        Uri.parse('${UrlConstant}/wishlist/getitems/${userId.value}'),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        final List<dynamic> jsonList = result['data'];
        
      }
    } catch (e) {
      debugPrint('Unexpected error occurred!Please try again later: $e');
    }
  }
}
