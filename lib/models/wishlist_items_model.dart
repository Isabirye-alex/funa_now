import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

class WishlistItemsModel {
  int user_id;
  String product_image;
  String product_name;
  String product_price;

  WishlistItemsModel({
    required this.user_id,
    required this.product_image,
    required this.product_name,
    required this.product_price,
  });

  WishlistItemsModel copyWith({
    int? user_id,
    String? product_image,
    String? product_name,
    String? product_price,
  }) {
    return WishlistItemsModel(
      user_id: user_id ?? this.user_id,
      product_image: product_image ?? this.product_image,
      product_name: product_name ?? this.product_name,
      product_price: product_price ?? this.product_price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'product_image': product_image,
      'product_name': product_name,
      'product_price': product_price,
    };
  }

  factory WishlistItemsModel.fromMap(Map<String, dynamic> map) {
    return WishlistItemsModel(
      user_id: map['user_id'] as int,
      product_image: map['product_image'] as String,
      product_name: map['product_name'] as String,
      product_price: map['product_price'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WishlistItemsModel.fromJson(String source) => WishlistItemsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
