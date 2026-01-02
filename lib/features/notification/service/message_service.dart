import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techmart/core/widgets/choice_chips.dart/choicechips.dart';
import 'package:techmart/features/authentication/service/Auth_service.dart';
import 'package:techmart/features/notification/model/notification_model.dart';

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

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  List<String> existing = prefs.getStringList('notifications') ?? [];

  final notification = NotificationModel(
    title: message.notification?.title ?? "No Title",
    message: message.notification?.body ?? "No Body",
  );

  existing.add(jsonEncode(notification.toMap()));
  await prefs.setStringList('notifications', existing);

  Logger().i(
    "💤 Background notification saved automatically: ${notification.title}",
  );
}
