// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fchat/src/data/models/user_model.dart';

class MessageModel {
  final int id;
  final String message;
  final DateTime date;
  final UserModel author;

  MessageModel({
    required this.id,
    required this.message,
    required this.date,
    required this.author,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'date': date,
      'author': author.toMap(),
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] as int,
      message: map['message'] as String,
      date: map['date'],
      author: UserModel.fromMap(map['author'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
