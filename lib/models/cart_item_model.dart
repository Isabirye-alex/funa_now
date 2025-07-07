import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartItemModel {
  final int id;
  final int productId;
  final int cartId;
  final int quantity;
  final String imageUrl;
  final String title;
  final double? price;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.cartId,
    required this.quantity,
    required this.imageUrl,
    required this.title,
    this.price,
  });

  CartItemModel copyWith({
    int? id,
    int? productId,
    int? cartId,
    int? quantity,
    String? imageUrl,
    String? title,
    double? price,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      cartId: cartId ?? this.cartId,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'cartId': cartId,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'title': title,
      'price': price,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] as int,
      productId: map['productId'] as int,
      cartId: map['cartId'] as int,
      quantity: map['quantity'] as int,
      imageUrl: map['imageUrl'] as String,
      title: map['title'] as String,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartItemModel(id: $id, productId: $productId, cartId: $cartId, quantity: $quantity, imageUrl: $imageUrl, title: $title, price: $price)';
  }
}
