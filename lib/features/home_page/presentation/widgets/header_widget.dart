import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Discover", style: Theme.of(context).textTheme.displaySmall),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_none, size: 35, weight: 50),
        ),
      ],
    );
  }
}
