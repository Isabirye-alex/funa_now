// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
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
  void addToCart(ProductsModel product, BuildContext context) async {
    try {
      quantity.value = 1;

      final response = await http.post(
        Uri.parse('http://192.168.100.57:3000/cart-items/addtocart'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': 7,
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
        Uri.parse(
          'http://192.168.100.57:3000/cart-items/getcartitems/${cart_id.value}',
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          final items = data['data'] as List;
          cartItem.value = items.map((e) => CartItemModel.fromMap(e)).toList();
          debugPrint('Cart items fetched: ${cartItem.length}');
          update();
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

  Future<void> decreaseItemQuantity(int itemId, BuildContext context) async {
    try {
      final response = await http.patch(
        Uri.parse('http://192.168.100.57:3000/cart-items/decrease/$itemId'),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success']) {
        Flushbar(
          shouldIconPulse: false,
          borderRadius: BorderRadius.circular(8),
          margin: EdgeInsets.all(24),
          flushbarPosition: FlushbarPosition.TOP,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: const Color.fromARGB(255, 78, 9, 239),
          messageText: Text(
            'Success',
            style: const TextStyle(color: Colors.white),
          ),
          duration: const Duration(seconds: 4),
          icon: Icon(Icons.check_circle, color: Colors.white),
          titleText: Text(
            'Item removed from cart',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ).show(context);
        noOfItems--;
        update();
        debugPrint('Quantity decreased');
        await fetchCartItems();
      } else {
        debugPrint('Failed to decrease quantity: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error decreasing quantity: $e');
    }
  }

  Future<void> loadCartOnAppStart(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.100.57:3000/cart-items/activecart/$userId'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        cart_id.value = data['cart_id'];
        await fetchCartItems();
      } else {
        debugPrint('No active cart found: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error loading cart: $e');
    }
  }

  Future<void> removeItemFromCart(int itemId) async {
    try {
      final response = await http.delete(
        Uri.parse('http://192.168.100.57:3000/cart-items/deleteitem/$itemId'),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201 && data['success']) {
        debugPrint('Item removed successfully');
        await fetchCartItems();
      } else {
        debugPrint('Failed to remove item: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error removing item: $e');
    }
  }
}
