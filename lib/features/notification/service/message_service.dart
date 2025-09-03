import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class MessageService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
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

      Logger().i("deviceToken $deviceToken");
    } catch (e) {
      Logger().d(e.toString());
    }
  }

  sendNoticiation() {}
}
