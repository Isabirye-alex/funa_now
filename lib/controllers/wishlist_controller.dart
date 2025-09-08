// ignore_for_file: use_build_context_synchronously

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:go_shop/features/constants/url_constant.dart';
import 'package:go_shop/features/helper_function/db_helper.dart';
import 'package:go_shop/models/wishlist_items_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:go_shop/models/wishlist_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();
  RxList<WishlisModel> wishlist = <WishlisModel>[].obs;
  final RxnInt userId = RxnInt();
  final authService = AuthStorage();
  var isWislisted = false.obs;
  var wishlistedIds = <int>{}.obs;
  bool isWishlisted(int productId) => wishlistedIds.contains(productId);
  RxList<WishlistItemsModel> items = <WishlistItemsModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadUserId();
    getWishListItems();
    loadWishlist();
  }

  Future<void> loadUserId() async {
    final dbquery = await authService.getAuthData();
    if (dbquery != null && dbquery['userId'] != null) {
      userId.value = dbquery['userId'];

    } else {

    }
  }

  Future<bool> checkUserLoggedIn(BuildContext context) async {
    await loadUserId();
    if (userId.value == null) {
      Flushbar(
        shouldIconPulse: false,
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

  void toggleWishList(int productId) async {
    if (wishlistedIds.contains(productId)) {
      wishlistedIds.remove(productId);
      items.removeWhere((item) => item.product_id == productId);
      await removeItemFromWishList(productId);
    } else {
      wishlistedIds.add(productId);
      await addItemToWishList(productId);
      await getWishListItems();
    }
    await saveWishlist();
  }

  Future<void> addItemToWishList(int productId) async {
    await loadUserId();
    if (userId.value == null) {
      return;
    }
    try {
      final wishlist = WishlisModel(
        product_id: productId,
        user_id: userId.value!,
      );
      final response = await http.post(
        Uri.parse('${UrlConstant.url}wishlist/additem/${userId.value}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(wishlist.toMap()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {}
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
        Uri.parse('${UrlConstant.url}wishlist/getitems/${userId.value}'),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        final List<dynamic> jsonList = result['data'];
        final List<WishlistItemsModel> res = jsonList
            .map((i) => WishlistItemsModel.fromMap(i))
            .toList();
        items.assignAll(res);
      } else {}
    } catch (e) {
      debugPrint('Unexpected error occurred!Please try again later: $e');
    }
  }

  Future<void> removeItemFromWishList(int productId) async {
    try {
      final uri = Uri.parse(
        '${UrlConstant.url}wishlist/removefromwishlist/${userId.value}',
      );
      final request = http.Request('DELETE', uri)
        ..headers['Content-Type'] = 'application/json'
        ..body = jsonEncode({'product_id': productId});

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {}
    } catch (e) {
      debugPrint('Error removing item from wishlist: $e');
    }
  }

  Future<void> saveWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    // Convert integers to strings for storage
    await prefs.setStringList(
      'wishlist',
      wishlistedIds.map((id) => id.toString()).toList(),
    );
  }

  Future<void> loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('wishlist') ?? [];
    // Convert strings back to integers and add to wishlistedIds
    wishlistedIds.addAll(savedList.map(int.parse));
  }
}
