import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:techmart/core/widgets/snakbar_widgert.dart';

copyToClipBoard(String data, BuildContext context) async {
  final clipData = ClipboardData(text: data);
  await Clipboard.setData(clipData);
  if (context.mounted) {
    custemSnakbar(
      context: context,
      message: "Order No. Copied",
      color: Colors.green,
    );
  }
}
