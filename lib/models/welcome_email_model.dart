import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WelcomeEmailModel {
  String receiver;
  String receiverName;

  WelcomeEmailModel({required this.receiver, required this.receiverName});

  WelcomeEmailModel copyWith({String? receiver, String? receiverName}) {
    return WelcomeEmailModel(
      receiver: receiver ?? this.receiver,
      receiverName: receiverName ?? this.receiverName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'receiver': receiver,
      'receiverName': receiverName,
    };
  }

  factory WelcomeEmailModel.fromMap(Map<String, dynamic> map) {
    return WelcomeEmailModel(
      receiver: map['receiver'] as String,
      receiverName: map['receiverName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WelcomeEmailModel.fromJson(String source) =>
      WelcomeEmailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
