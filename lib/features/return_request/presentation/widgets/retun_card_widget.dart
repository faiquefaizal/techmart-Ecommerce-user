import 'package:flutter/material.dart';

class ReturnReasonWisget extends StatelessWidget {
  const ReturnReasonWisget({
    super.key,
    required TextEditingController returnReasonController,
  }) : _returnReasonController = returnReasonController;

  final TextEditingController _returnReasonController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _returnReasonController,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: "Enter your reason for return",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
