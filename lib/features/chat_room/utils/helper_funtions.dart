import 'package:flutter/cupertino.dart';
import 'package:techmart/features/authentication/service/Auth_service.dart';

bool usercheck(String senderId) {
  final userId = AuthService().getUserId();
  if (senderId == userId) {
    return true;
  }
  return false;
}

void scrollDown(ScrollController controller) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
    );
  });
}
