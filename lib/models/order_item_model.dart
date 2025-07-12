import 'dart:convert';

class OrderItemModel {
  int id;
  int orderId;
  int productId;
  int quantity;
  String price;
  String productName;
  String productImage;
  String productPrice;

  OrderItemModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.productName,
    required this.productImage,
    required this.productPrice,
  });

  OrderItemModel copyWith({
    int? id,
    int? orderId,
    int? productId,
    int? quantity,
    String? price,
    String? productName,
    String? productImage,
    String? productPrice,
  }) => OrderItemModel(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    productId: productId ?? this.productId,
    quantity: quantity ?? this.quantity,
    price: price ?? this.price,
    productName: productName ?? this.productName,
    productImage: productImage ?? this.productImage,
    productPrice: productPrice ?? this.productPrice,
  );

  factory OrderItemModel.fromRawJson(String str) =>
      OrderItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
    id: json["id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    price: json["price"],
    productName: json["product_name"],
    productImage: json["product_image"],
    productPrice: json["product_price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "quantity": quantity,
    "price": price,
    "product_name": productName,
    "product_image": productImage,
    "product_price": productPrice,
  };
}
