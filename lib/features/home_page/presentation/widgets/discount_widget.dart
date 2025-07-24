import 'package:flutter/material.dart';

class discount_widget extends StatelessWidget {
  const discount_widget({super.key, required this.discount});

  final int discount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.green,
      ),
      child: Text(
        '$discount% OFF',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class dicount_widget extends StatelessWidget {
  const dicount_widget({super.key, required this.discount});

  final int discount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$discount% OFF',
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.green[800],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
