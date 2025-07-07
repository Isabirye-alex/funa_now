import 'dart:convert';

class CartItemModel {
  final int id;
  final int productId;
  final int cartId;
  final int quantity;
  final String imageUrl;
  final String title;
  final double price;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.cartId,
    required this.quantity,
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] as int,
      productId: map['product_id'] as int,
      cartId: map['cart_id'] as int,
      quantity: map['quantity'] as int,
      imageUrl: map['imageUrl']?.toString() ?? '', // prevent null
      title: map['title']?.toString() ?? '',
      price: double.tryParse(map['price'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'cart_id': cartId,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'title': title,
      'price': price.toStringAsFixed(2),
    };
  }

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CartItemModel(id: $id, productId: $productId, cartId: $cartId, quantity: $quantity, imageUrl: $imageUrl, title: $title, price: $price)';
  }
}
