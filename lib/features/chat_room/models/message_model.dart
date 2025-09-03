import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final String senderId;
  final String message;
  final DateTime? time;
  const MessageModel({
    required this.message,
    required this.senderId,
    this.time,
  });

  Map<String, dynamic> toMap() => {
    "senderId": senderId,
    "message": message,
    "time": FieldValue.serverTimestamp(),
  };
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map["message"],
      senderId: map["senderId"],
      time: (map["time"] as Timestamp?)?.toDate(),
    );
  }
  @override
  List<Object?> get props => [time];
}
