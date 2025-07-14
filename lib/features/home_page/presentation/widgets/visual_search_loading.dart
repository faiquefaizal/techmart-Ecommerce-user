import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

visualSearchLoading(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    builder:
        (_) =>
            Center(child: Lottie.asset('assets/ai_loading.json', width: 180)),
  );
}
