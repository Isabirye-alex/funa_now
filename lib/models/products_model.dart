// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:intl/intl.dart';
class ProductsModel {
  int? id;hn
  String name;
  String? description;
  String price;
  int? stock;
  String imageUrl;
  int? isFeatured;
  String? brand;
  int? categoryId;
  String? categoryName;
  double? percentage_discount;

  String get formattedPrice {
    final double? parsed = double.tryParse(price);
    if (parsed == null) return '0';
    final int rounded = parsed.toInt(); // remove decimal part
    return NumberFormat('#,###').format(rounded); // format with commas
  }

  ProductsModel({
    this.id,
    required this.name,
    this.description,
    required this.price,
    this.stock,
    required this.imageUrl,
    this.isFeatured,
    this.brand,
    this.categoryId,
    this.categoryName,
    this.percentage_discount,
  });

  factory ProductsModel.fromRawJson(String str) =>
      ProductsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'imageUrl': imageUrl,
      'isFeatured': isFeatured,
      'brand': brand,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'percentage_discount': percentage_discount,
    };
  }

  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      id: map['id'] != null ? int.tryParse(map['id'].toString()) : null,
      name: map['name'] as String,
      description: map['description']?.toString(),
      price: map['price'].toString(),
      stock: map['stock'] != null ? int.tryParse(map['stock'].toString()) : null,
      imageUrl: map['imageUrl'] as String,
      isFeatured: map['isFeatured'] != null
          ? int.tryParse(map['isFeatured'].toString())
          : null,
      brand: map['brand']?.toString(),
      categoryId: map['categoryId'] != null
          ? int.tryParse(map['categoryId'].toString())
          : null,
      categoryName: map['categoryName']?.toString(),
      percentage_discount: map['percentage_discount'] != null
          ? double.tryParse(map['percentage_discount'].toString())
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductsModel.fromJson(String source) =>
      ProductsModel.fromMap(json.decode(source) as Map<String, dynamic>);

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
    double? percentage_discount,
  }) {
    return ProductsModel(
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
      percentage_discount: percentage_discount ?? this.percentage_discount,
    );
  }
}
