import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

class WishlisModel {
  int? id;
  String user_id;
  String product_id;

  WishlisModel({
    this.id,
    required this.product_id,
    required this.user_id
  });

  WishlisModel copyWith({
    int? id,
    String? user_id,
    String? product_id,
  }) {
    return WishlisModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      product_id: product_id ?? this.product_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'product_id': product_id,
    };
  }

  factory WishlisModel.fromMap(Map<String, dynamic> map) {
    return WishlisModel(
      id: map['id'] != null ? map['id'] as int : null,
      user_id: map['user_id'] as String,
      product_id: map['product_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WishlisModel.fromJson(String source) => WishlisModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
