// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int? id;
  String firstName;
  String lastName;
  String email;
  String username;
  String password;
  DateTime? creationDate;
  dynamic imageUrl;

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.password,
    this.creationDate,
    this.imageUrl,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    username: json["username"],
    password: json["password"],
    creationDate: DateTime.parse(json["creationDate"]),
    imageUrl: json["imageUrl"],
  );

  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? username,
    String? password,
    DateTime? creationDate,
    dynamic imageUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      creationDate: creationDate ?? this.creationDate,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'password': password,
      'creationDate': creationDate?.millisecondsSinceEpoch,
      'imageUrl': imageUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      creationDate: map['creationDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['creationDate'] as int)
          : null,
      imageUrl: map['imageUrl'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());
}
