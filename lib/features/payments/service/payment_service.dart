import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart';
import 'package:techmart/features/payments/const/payment.dart';
import 'package:techmart/features/payments/funtions/support_funtions.dart';

class PaymentService {
  Future<String> makePayment(int amount) async {
    try {
      var result = await _paymentInit(amount);
      if (result == null) {
        throw Exception("missing payment id so error");
      }
      String paymentId = result["paymentId"]!;
      String clientId = result["clientSecret"]!;
      await _paymentUiSheet(clientId);
      return paymentId;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, String>?> _paymentInit(int amount) async {
    Dio dio = Dio();
    final data = {"amount": convertAmount(amount), "currency": "INR"};

    try {
      final respose = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $secretkey',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (respose == null) {
        log(respose.toString());
        return null;
      }

      return {
        "paymentId": respose.data["id"],
        "clientSecret": respose.data["client_secret"],
      };
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _paymentUiSheet(String id) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: id,
          merchantDisplayName: "Tech Mart",
          style: ThemeMode.dark,
        ),
      );
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      log(e.toString());
    }
  }
}
