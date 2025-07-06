import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:go_shop/models/cart_model.dart';
import 'package:go_shop/models/cart_item_model.dart';

class CartController extends GetxController {
  final Rx<CartModel?> cart = Rx<CartModel?>(null);
  final RxList<CartItemModel> items = <CartItemModel>[].obs;

  final int userId = 1; 

  final baseUrl = 'http://192.168.1.7:3000'; 

  @override
  void onInit() {
    super.onInit();
    fetchOrCreateCart();
  }

  Future<void> fetchOrCreateCart() async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/cart'),
        body: {'user_id': userId.toString()},
      );

      final data = jsonDecode(res.body);
      if (data['success']) {
        cart.value = CartModel.fromJson(data['data']);
        getCartItems();
      } else {
        Get.snackbar('Error', data['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch cart: $e');
    }
  }

  Future<void> getCartItems() async {
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/cart/items/${cart.value!.id}'),
      );
      final data = jsonDecode(res.body);

      if (data['success']) {
        final List<CartItemModel> loaded = (data['data'] as List)
            .map((e) => CartItemModel.fromJson(e))
            .toList();
        items.assignAll(loaded);
      } else {
        Get.snackbar('Cart Empty', data['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Unable to load cart items: $e');
    }
  }

  Future<void> addToCart(int productId, int quantity) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/cart/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'productId': productId,
          'quantity': quantity,
        }),
      );

      final data = jsonDecode(res.body);

      if (data['success']) {
        Get.snackbar('Success', 'Item added to cart');
        getCartItems();
      } else {
        Get.snackbar('Error', data['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Add to cart failed: $e');
    }
  }

  Future<void> removeItem(int itemId) async {
    try {
      final res = await http.delete(Uri.parse('$baseUrl/cart/remove/$itemId'));
      final data = jsonDecode(res.body);

      if (data['success']) {
        items.removeWhere((item) => item.id == itemId);
        Get.snackbar('Removed', 'Item removed from cart');
      } else {
        Get.snackbar('Error', data['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Remove failed: $e');
    }
  }
}
