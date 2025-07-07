import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custemAppbar(heading: "My Cart", context: context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/cart.json",
              height: 150,
              animate: true,
              repeat: true,
            ),

            Text(
              'Your Cart is Empty!',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "When you add products,they'll",
              style: TextStyle(fontSize: 14, color: Colors.grey[400]),
              textAlign: TextAlign.center,
            ),

            Text(
              "Appear here.",
              style: TextStyle(fontSize: 14, color: Colors.grey[400]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
