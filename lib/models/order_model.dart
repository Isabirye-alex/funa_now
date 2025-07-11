// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class OrderModel {
  int? id;
  int user_id;
  String total_amount;
  String status;
  String shipping_address;
  String payment_method;
  int? isPaid;
  dynamic paidAt;
  dynamic deliveredAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String userName;

  OrderModel({
    this.id,
    required this.user_id,
    required this.total_amount,
    required this.status,
    required this.shipping_address,
    required this.payment_method,
    this.isPaid,
    this.paidAt,
    this.deliveredAt,
    this.createdAt,
    this.updatedAt,
    required this.userName,
  });

  OrderModel copyWith({
    int? id,
    int? user_id,
    String? total_amount,
    String? status,
    String? shipping_address,
    String? payment_method,
    int? isPaid,
    dynamic paidAt,
    dynamic deliveredAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userName,
  }) {
    return OrderModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      total_amount: total_amount ?? this.total_amount,
      status: status ?? this.status,
      shipping_address: shipping_address ?? this.shipping_address,
      payment_method: payment_method ?? this.payment_method,
      isPaid: isPaid ?? this.isPaid,
      paidAt: paidAt ?? this.paidAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'total_amount': total_amount,
      'status': status,
      'shipping_address': shipping_address,
      'payment_method': payment_method,
      'isPaid': isPaid,
      'paidAt': paidAt,
      'deliveredAt': deliveredAt,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'userName': userName,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] != null ? map['id'] as int : null,
      user_id: map['user_id'] as int,
      total_amount: map['total_amount'] as String,
      status: map['status'] as String,
      shipping_address: map['shipping_address'] as String,
      payment_method: map['payment_method'] as String,
      isPaid: map['isPaid'] != null ? map['isPaid'] as int : null,
      paidAt: map['paidAt'] as dynamic,
      deliveredAt: map['deliveredAt'] as dynamic,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
      userName: map['userName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
