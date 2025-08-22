import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:techmart/core/utils/price_formater.dart';

String formatTime(DateTime dateStr) {
  try {
    final date = dateStr.toLocal();
    return DateFormat('MMM dd, hh:mm a').format(date);
  } catch (_) {
    return "invalid format";
  }
}

List<Widget> imageIcons = [
  SvgPicture.asset("assets/status_order_placed.svg"),
  Icon(Icons.check_circle, color: Colors.white),
  Icon(Icons.local_shipping, color: Colors.white),
  Icon(Icons.delivery_dining, color: Colors.white),
  Icon(Icons.home_rounded, color: Colors.white),
];
final List<String> displayLabels = const [
  "Order Placed",
  "Processing",
  "Shipped",
  "Out for Delivery",
  "Delivered",
];
List<Widget> currentWidget = [
  // Lottie.asset();
];
double getTaxInfo(double amount) {
  return amount * (18 / 100);
}

double beforeTax(double amount) {
  return amount - getTaxInfo(amount);
}

String formatIndianPrice(String amount) {
  final format = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );
  return format.format(int.parse(amount));
}

bool ckeckEligibleforReturn(DateTime date) {
  DateTime currentTime = DateTime.now();
  Duration diffrents = currentTime.difference(date);
  Logger().e(diffrents.inDays.toString());

  return (diffrents.inDays <= 7);
}

String maxRetrunDate(DateTime date) {
  DateTime maxDate = date.add(Duration(days: 7));
  return maxDate.toFancyFormat();
}
