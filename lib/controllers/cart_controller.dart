import 'package:get/get.dart';
import 'package:go_shop/models/cart_item_model.dart';
import 'package:go_shop/models/cart_model.dart';
import 'package:go_shop/models/products_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class CartController extends GetxController {
  RxInt noOfItems = 0.obs;
  RxInt quantity = 0.obs;
  RxDouble totalPrice = 0.0.obs;
  RxList<CartItemModel> cartItem = <CartItemModel>[].obs;
  RxList<CartModel> cart = <CartModel>[].obs;

  void addToCart(ProductsModel product) async {
    try {
      // Set at least quantity 1
      if (quantity.value < 1) {
        quantity.value = 1;
      } else {
        quantity.value += quantity.value;
      }

      final response = await http.post(
        Uri.parse(
          'http://192.168.100.57:3000/addtocart',
        ), // Update to your correct URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': 1, // replace with the logged-in user’s id
          'productId': product.id,
          'quantity': quantity.value,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint('Item added: $data');
        noOfItems++;
        // Optional: fetch cart items again
      } else {
        debugPrint('Failed to add item: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
