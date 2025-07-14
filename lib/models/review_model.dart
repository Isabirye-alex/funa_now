import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

class ReviewModel {
  int? id;
  int user_id;
  String comment;
  double rating;
  int product_id;
  DateTime? created_at;

  ReviewModel({
    this.id,
    required this.user_id,
    required this.comment,
    required this.rating,
    required this.product_id,
    this.created_at,
  });

  ReviewModel copyWith({
    int? id,
    int? user_id,
    String? comment,
    double? rating,
    int? product_id,
    DateTime? created_at,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      comment: comment ?? this.comment,
      rating: rating ?? this.rating,
      product_id: product_id ?? this.product_id,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'comment': comment,
      'rating': rating,
      'product_id': product_id,
      'created_at': created_at?.millisecondsSinceEpoch,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      id: map['id'] != null ? map['id'] as int : null,
      user_id: map['user_id'] as int,
      comment: map['comment'] as String,
      rating: (map['rating'] is int)
          ? (map['rating'] as int).toDouble()
          : map['rating'] as double,
      product_id: map['product_id'] as int,
      created_at: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
