import 'package:cloud_firestore/cloud_firestore.dart';

class IaChatModel {
  String id;
  String lastMessage;
  DateTime timestamp;

  IaChatModel({
    required this.id,
    required this.lastMessage,
    required this.timestamp,
  });

  //factory
  factory IaChatModel.fromJson(Map<String, dynamic> json) {
    return IaChatModel(
      id: json['id'] as String,
      lastMessage: json['lastMessage'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}
