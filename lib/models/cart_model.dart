import 'dart:convert';

class CartModel {
  int id;
  int userId;
  String totalPrice;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  CartModel({
    required this.id,
    required this.userId,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  CartModel copyWith({
    int? id,
    int? userId,
    String? totalPrice,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CartModel(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    totalPrice: totalPrice ?? this.totalPrice,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory CartModel.fromRawJson(String str) => CartModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json["id"],
    userId: json["user_id"],
    totalPrice: json["total_price"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "total_price": totalPrice,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
