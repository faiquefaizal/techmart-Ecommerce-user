import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';

import 'package:googleapis_auth/auth_io.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class ServerSideFuntion {
  static const projectId = "techmart-ecd96";
  static const scopes = ["https://www.googleapis.com/auth/firebase.messaging"];
  static Future<String> obtainKey() async {
    final jsonData = await rootBundle.loadString(
      "assets/techmart-ecd96-44ba9fae2451.json",
    );
    Logger().i(jsonData);
    return jsonData;
  }

  static Future<String> getAccessToken() async {
    final key = await obtainKey();
    ServiceAccountCredentials accountcredentials =
        ServiceAccountCredentials.fromJson(key);

    AuthClient authClient = await clientViaServiceAccount(
      accountcredentials,
      scopes,
    );
    final authTocken = authClient.credentials.accessToken.data;
    Logger().w("auht key:$authTocken");
    return authTocken;
  }

  static void sendFcmServer(
    String targetDeviceTocken,
    String messageTitle,
    String messageBody,
  ) async {
    final accessTocken = await getAccessToken();
    final uri = Uri.parse(
      "https://fcm.googleapis.com/v1/projects/$projectId/messages:send",
    );
    final data = {
      "message": {
        "token": targetDeviceTocken,
        "notification": {"title": messageTitle, "body": messageBody},
      },
    };
    final respond = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessTocken",
      },
      body: jsonEncode(data),
    );
    if (respond.statusCode >= 200 && respond.statusCode < 300) {
      Logger().i("success: ${respond.body}");
    } else {
      throw Exception(
        'FCM v1 send failed: ${respond.statusCode} ${respond.body}',
      );
    }
  }
}
