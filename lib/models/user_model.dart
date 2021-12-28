import 'package:flutter/material.dart';

@immutable
class UserModel{
  final String uid;
  final String email;
  final String name;
  final String image;

  const UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'email': email,
      'fullName': name,
      'photoUrl': image,
    };
  }

  factory UserModel.fromMap(map){
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        name: map['name'],
        image: map['photoUrl'],
    );
  }

  factory UserModel.fromDocument(Map<String, dynamic> doc) {
    return UserModel(
        uid: doc['uid'].toString(),
        email: doc["email"].toString(),
        name: doc["fullName"].toString(),
        image: doc["photoUrl"].toString(),
    );
  }
}
