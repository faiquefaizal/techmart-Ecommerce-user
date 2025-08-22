import 'package:flutter/material.dart';

class StatusWisget extends StatelessWidget {
  final String status;
  const StatusWisget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
      ),
    );
  }
}
