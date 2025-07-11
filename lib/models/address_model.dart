import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

class AddressModel {
  int? id;
  final String user_id;
  final String address_line;
  final String region;
  final String district;
  final String postal_code;
  final String? country;

  AddressModel({
    this.id,
    required this.user_id,
    required this.address_line,
    required this.district,
    required this.postal_code,
    required this.region,
    this.country,
  });


  AddressModel copyWith({
    int? id,
    String? user_id,
    String? address_line,
    String? region,
    String? district,
    String? postal_code,
    String? country,
  }) {
    return AddressModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      address_line: address_line ?? this.address_line,
      region: region ?? this.region,
      district: district ?? this.district,
      postal_code: postal_code ?? this.postal_code,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'address_line': address_line,
      'region': region,
      'district': district,
      'postal_code': postal_code,
      'country': country,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] != null ? map['id'] as int : null,
      user_id: map['user_id'] as String,
      address_line: map['address_line'] as String,
      region: map['region'] as String,
      district: map['district'] as String,
      postal_code: map['postal_code'] as String,
      country: map['country'] != null ? map['country'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) => AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
