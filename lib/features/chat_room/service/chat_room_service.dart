import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techmart/core/widgets/choice_chips.dart/choicechips.dart';
import 'package:techmart/features/authentication/service/Auth_service.dart';
import 'package:techmart/features/chat_room/models/message_model.dart';

class ChatRoomService {
  final CollectionReference _chatRoomRef = FirebaseFirestore.instance
      .collection("ChatRoom");
  String get userId {
    return AuthService().getUserId()!;
  }

  Stream<List<MessageModel>> fetchMessages(String recieverId) {
    String chatRoomId = getChatRoomId(recieverId);
    final chatSnaps =
        _chatRoomRef
            .doc(chatRoomId)
            .collection("Messages")
            .orderBy("time", descending: false)
            .snapshots();
    return chatSnaps.map(
      (snap) =>
          snap.docs.map((doc) => MessageModel.fromMap(doc.data())).toList(),
    );
  }

  sendMessage(String recieverId, String message) async {
    String chatRoomId = getChatRoomId(recieverId);

    MessageModel messageModel = MessageModel(
      message: message,
      senderId: userId,
    );
    await _chatRoomRef
        .doc(chatRoomId)
        .collection("Messages")
        .add(messageModel.toMap());

    _chatRoomRef.doc(chatRoomId).set({
      "participants": FieldValue.arrayUnion([userId, recieverId]),
      "lastMessage": message,
      "lastMessageTime": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  String getChatRoomId(String recieverId) {
    final String currentUser = AuthService().getUserId()!;
    List<String> ids = [currentUser, recieverId];
    ids.sort();
    return ids.join("_");
  }
}
