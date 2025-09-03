import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/chat_room/bloc/message_bloc.dart';
import 'package:techmart/features/chat_room/cubit/cubit/message_cubit.dart';

class SendMessageField extends StatelessWidget {
  const SendMessageField({super.key});

  @override
  Widget build(BuildContext context) {
    final messagecubic = context.watch<MessageCubit>().state;
    final messageBloc = context.watch<MessageBloc>().state;
    if (messageBloc is! MessageFetched) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.065,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {
                  log(value);
                  context.read<MessageCubit>().checkMessage(
                    messageBloc.messageController.text.trim(),
                  );
                },
                controller: messageBloc.messageController,
                focusNode: messageBloc.nodeController,
                decoration: InputDecoration(
                  hintText: "Write your Message",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            HorizontalSpaceWisget(8),
            IgnorePointer(
              ignoring: (messagecubic is MessageEmpty),
              child: GestureDetector(
                onTap: () {
                  log(messageBloc.messageController.text.trim());
                  assert(
                    messageBloc.messageController.text.trim().isNotEmpty,
                    "message cannot be null",
                  );
                  context.read<MessageBloc>().add(
                    SendMessage(messageBloc.messageController.text.trim()),
                  );
                },

                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color:
                        (messagecubic is MessageEmpty)
                            ? Colors.grey
                            : Colors.black,
                  ),
                  height: double.infinity,
                  width: 50,

                  child: Icon(Icons.send, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
