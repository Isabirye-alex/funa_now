import 'dart:convert';

import 'package:intl/intl.dart';

class ProductsModel {
  int id;
  String name;
  String description;
  String price;
  int stock;
  String imageUrl;
  int isFeatured;
  String brand;
  int categoryId;
  String categoryName;
  int subcategoryId;
  String subcategoryName;
  // int get priceInt => double.tryParse(price)?.toInt() ?? 0;
  
  String get formattedPrice {
    final double? parsed = double.tryParse(price);
    if (parsed == null) return '0';
    final int rounded = parsed.toInt(); // remove decimal part
    return NumberFormat('#,###').format(rounded); // format with commas
  }
  ProductsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.imageUrl,
    required this.isFeatured,
    required this.brand,
    required this.categoryId,
    required this.categoryName,
    required this.subcategoryId,
    required this.subcategoryName,
  });

  ProductsModel copyWith({
    int? id,
    String? name,
    String? description,
    String? price,
    int? stock,
    String? imageUrl,
    int? isFeatured,
    String? brand,
    int? categoryId,
    String? categoryName,
    int? subcategoryId,
    String? subcategoryName,
  }) => ProductsModel(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    price: price ?? this.price,
    stock: stock ?? this.stock,
    imageUrl: imageUrl ?? this.imageUrl,
    isFeatured: isFeatured ?? this.isFeatured,
    brand: brand ?? this.brand,
    categoryId: categoryId ?? this.categoryId,
    categoryName: categoryName ?? this.categoryName,
    subcategoryId: subcategoryId ?? this.subcategoryId,
    subcategoryName: subcategoryName ?? this.subcategoryName,
  );

  factory ProductsModel.fromRawJson(String str) =>
      ProductsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    stock: json["stock"],
    imageUrl: json["imageUrl"],
    isFeatured: json["is_featured"],
    brand: json["brand"],
    categoryId: json["category_id"],
    categoryName: json["categoryName"],
    subcategoryId: json["subcategory_id"],
    subcategoryName: json["subcategoryName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price as int,
    "stock": stock,
    "imageUrl": imageUrl,
    "is_featured": isFeatured,
    "brand": brand,
    "category_id": categoryId,
    "categoryName": categoryName,
    "subcategory_id": subcategoryId,
    "subcategoryName": subcategoryName,
  };
}
