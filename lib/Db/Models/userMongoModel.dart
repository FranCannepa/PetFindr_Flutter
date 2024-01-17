import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

UserMongoModel userMongoModelFromJson(String str) =>
    UserMongoModel.fromJson(json.decode(str));

String userMongoModelToJson(UserMongoModel data) => json.encode(data.toJson());

class UserMongoModel {
  ObjectId id;
  String email;
  String password;
  String username;

  UserMongoModel({
    required this.id,
    required this.email,
    required this.password,
    required this.username,
  });

  factory UserMongoModel.fromJson(Map<String, dynamic> json) => UserMongoModel(
        id: json["_id"],
        email: json["email"],
        password: json["password"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "password": password,
        "username": username,
      };
}
