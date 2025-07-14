// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_shop/features/constants/url_constant.dart';
import 'package:go_shop/features/helper_function/db_helper.dart';
import 'package:go_shop/models/cart_item_model.dart';
import 'package:go_shop/models/cart_model.dart';
import 'package:go_shop/models/products_model.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  static CartController get to => Get.find();
  RxInt noOfItems = 0.obs;
  RxInt quantity = 0.obs;
  RxDouble totalPrice = 0.0.obs;
  RxList<CartItemModel> cartItem = <CartItemModel>[].obs;
  RxList<CartModel> cart = <CartModel>[].obs;
  var cart_id = RxnInt();
  final authStorage = AuthStorage();

  void addToCart(ProductsModel product, BuildContext context) async {
    try {
      final authData = await authStorage.getAuthData();
      if (authData != null) {
        quantity.value = 1;
        final userId = authData['userId'];
        final response = await http.post(
          Uri.parse('${UrlConstant.url}cart-items/addtocart'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'user_id': userId,
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
      } else {
        Flushbar(
          isDismissible: true,
          shouldIconPulse: false,
          borderRadius: BorderRadius.circular(8),
          margin: EdgeInsets.all(24),
          flushbarPosition: FlushbarPosition.TOP,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: const Color.fromARGB(255, 78, 9, 239),
          messageText: Text(
            'Error',
            style: const TextStyle(color: Colors.white),
          ),
          duration: const Duration(seconds: 4),
          icon: Icon(Icons.check_circle, color: Colors.white),
          titleText: Text(
            'Create account to start shopping',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ).show(context);
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> fetchCartItems() async {
    try {
      if (cart_id.value == null) {
        debugPrint('No valid cart ID found');
        cartItem.clear();
        return;
      }

      final response = await http.get(
        Uri.parse(
          '${UrlConstant.url}cart-items/getcartitems/${cart_id.value}',
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
        Uri.parse('${UrlConstant.url}cart-items/decrease/$itemId'),
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

  Future<void> updateCart() async {}

  Future<void> loadCartOnAppStart(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('${UrlConstant.url}cart-items/activecart/$userId'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);

        final data = body['data'];
        if (body['success'] == true && data != null && data['id'] != null) {
          final int cartId = data['id'];
          cart_id.value = cartId;
          await fetchCartItems();
        } else {
          debugPrint('No valid cart ID in response: $body');
          cart_id.value = null;
          cartItem.clear();
        }
      } else {
        debugPrint('Failed response: ${response.body}');
        cart_id.value = null;
        cartItem.clear();
      }
    } catch (e) {
      debugPrint('Error loading cart: $e');
      cart_id.value = null;
      cartItem.clear();
    }
  }

  Future<void> removeItemFromCart(int itemId) async {
    try {
      final response = await http.delete(
        Uri.parse('${UrlConstant.url}cart-items/deleteitem/$itemId'),
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

  Future<void> clearCart() async {
    cartItem.clear();
    cart.clear();
    cart_id.value = 0;
    noOfItems.value = 0;
    quantity.value = 0;
    totalPrice.value = 0.0;

    update();
  }
}
