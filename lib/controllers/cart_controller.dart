// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/models/cart_item_model.dart';
import 'package:go_shop/models/cart_model.dart';
import 'package:go_shop/models/products_model.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  RxInt noOfItems = 0.obs;
  RxInt quantity = 0.obs;
  RxDouble totalPrice = 0.0.obs;
  RxList<CartItemModel> cartItem = <CartItemModel>[].obs;
  RxList<CartModel> cart = <CartModel>[].obs;
  RxInt cart_id = 0.obs;
  void addToCart(ProductsModel product) async {
    try {
      quantity.value = 1; 

      final response = await http.post(
        Uri.parse('http://192.168.100.57:3000/addtocart'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': 2,
          'productId': product.id,
          'quantity': quantity.value,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint('Item added: $data');

        cart_id.value = data['data']['cart_id'];
        debugPrint('Cart id = ${cart_id.value}');

        await fetchCartItems();

        noOfItems++;
        update();
      } else {
        debugPrint('Failed to add item: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> fetchCartItems() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.100.57:3000/addtocart/${cart_id.value}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          final items = data['data'] as List;
          cartItem.value = items.map((e) => CartItemModel.fromMap(e)).toList();
          debugPrint('Cart items fetched: ${cartItem.length}');
        } else {
          debugPrint('Backend error: ${data['message']}');
          cartItem.clear();
        }
      } else {
        debugPrint('Failed to fetch cart items: ${response.body}');
        cartItem.clear();
      }
    } catch (e) {
      debugPrint('Error fetching cart items: $e');
    }
  }

  Future<void> removeItemFromCart()async {
    
  }
}
