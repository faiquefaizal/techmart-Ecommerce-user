import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'package:techmart/core/widgets/choice_chips.dart/choicechips.dart';
import 'package:techmart/features/authentication/service/Auth_service.dart';

class MessageService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  DocumentReference get _userDoc {
    final userId = AuthService().getUserId();

    return FirebaseFirestore.instance.collection("Users").doc(userId);
  }

  initialiazeNotification() async {
    try {
      final notificationStatus = await firebaseMessaging.requestPermission();
      if (notificationStatus.authorizationStatus ==
          AuthorizationStatus.authorized) {
        Logger().i("true accepoterd");
      } else {
        Logger().i("false rejsected");
      }
      final deviceToken = await firebaseMessaging.getToken();
      await _userDoc.set({"deviceToken": deviceToken}, SetOptions(merge: true));

      Logger().i("deviceToken $deviceToken");
    } catch (e) {
      Logger().d(e.toString());
    }
  }

  sendMessage() {}
}
