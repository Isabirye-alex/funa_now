// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

class ProductsModel {
  int? id;
  String name;
  String? description;
  String price;
  int? stock;
  String imageUrl;
  int? isFeatured;
  String? brand;
  int? categoryId;
  String? categoryName;
  int? subcategoryId;
  String? subcategoryName;
  // int get priceInt => double.tryParse(price)?.toInt() ?? 0;
  
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
     this.subcategoryId,
     this.subcategoryName,
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
      'subcategoryId': subcategoryId,
      'subcategoryName': subcategoryName,
    };
  }

  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      price: map['price'] as String,
      stock: map['stock'] != null ? map['stock'] as int : null,
      imageUrl: map['imageUrl'] as String,
      isFeatured: map['isFeatured'] != null ? map['isFeatured'] as int : null,
      brand: map['brand'] != null ? map['brand'] as String : null,
      categoryId: map['categoryId'] != null ? map['categoryId'] as int : null,
      categoryName: map['categoryName'] != null ? map['categoryName'] as String : null,
      subcategoryId: map['subcategoryId'] != null ? map['subcategoryId'] as int : null,
      subcategoryName: map['subcategoryName'] != null ? map['subcategoryName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductsModel.fromJson(String source) => ProductsModel.fromMap(json.decode(source) as Map<String, dynamic>);

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
      subcategoryId: subcategoryId ?? this.subcategoryId,
      subcategoryName: subcategoryName ?? this.subcategoryName,
    );
  }
}
