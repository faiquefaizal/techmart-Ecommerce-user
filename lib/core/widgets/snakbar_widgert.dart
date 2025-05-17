import 'package:flutter/material.dart';

custemSnakbar(BuildContext context, String message, Color color) {
  final snakbar = SnackBar(
    content: Text(message),
    backgroundColor: color,
    margin: EdgeInsets.all(8),
    behavior: SnackBarBehavior.floating,
    padding: EdgeInsets.all(10),
    duration: Duration(seconds: 2),
    dismissDirection: DismissDirection.vertical,
  );
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(snakbar);
}
