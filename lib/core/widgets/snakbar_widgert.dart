import 'package:flutter/material.dart';

void custemSnakbar({
  required BuildContext context,
  required String message,
  required Color color,
  VoidCallback? onUndo,
}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: color,
    margin: const EdgeInsets.all(8),
    behavior: SnackBarBehavior.floating,
    padding: const EdgeInsets.all(10),
    duration: const Duration(seconds: 3),
    dismissDirection: DismissDirection.vertical,
    action:
        onUndo != null
            ? SnackBarAction(
              label: 'UNDO',
              textColor: Colors.white,
              onPressed: onUndo,
            )
            : null,
  );

  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
