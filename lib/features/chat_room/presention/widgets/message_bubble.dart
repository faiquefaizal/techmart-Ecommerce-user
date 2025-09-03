import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';

class MessageBubble extends StatelessWidget {
  final bool userMessage;
  final String message;
  final DateTime time;
  const MessageBubble({
    super.key,
    required this.userMessage,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          userMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 13),
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: userMessage ? Colors.black : Colors.grey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomRight: userMessage ? Radius.zero : Radius.circular(12),
              bottomLeft: userMessage ? Radius.circular(12) : Radius.zero,
            ),
          ),

          child: Text(
            message,
            style: TextStyle(color: userMessage ? Colors.white : Colors.black),
          ),
        ),

        Padding(
          padding: EdgeInsetsGeometry.fromLTRB(
            userMessage ? 0 : 13,
            5,
            userMessage ? 13 : 0,
            5,
          ),
          child: Text(
            DateFormat('jm').format(time).toString(),
            style: TextStyle(color: Colors.grey.shade400),
          ),
        ),
      ],
    );
  }
}
