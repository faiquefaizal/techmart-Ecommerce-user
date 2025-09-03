import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/chat_room/bloc/message_bloc.dart';
import 'package:techmart/features/chat_room/presention/screens/chat_screen.dart';
import 'package:techmart/features/chat_room/service/chat_room_service.dart';

class NeedHelpButton extends StatelessWidget {
  final String sellerId;
  const NeedHelpButton({super.key, required this.sellerId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => (BlocProvider(
                    create:
                        (context) => MessageBloc(
                          TextEditingController(),
                          sellerId,
                          ChatRoomService(),
                          ScrollController(),
                          FocusNode(),
                        )..add(FetchMessages()),
                    child: ChatScreen(),
                  )),
            ),
          ),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message_outlined),
            HorizontalSpaceWisget(5),
            Text("Need Help?", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
