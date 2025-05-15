import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techmart/core/widgets/button_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [CustemButton(Label: " Logut", onpressed: () {})],
        ),
      ),
    );
  }
}
