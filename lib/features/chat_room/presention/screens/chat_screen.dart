import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/chat_room/bloc/message_bloc.dart';
import 'package:techmart/features/chat_room/cubit/cubit/message_cubit.dart'
    hide MessageState;

import 'package:techmart/features/chat_room/presention/widgets/message_bubble.dart';
import 'package:techmart/features/chat_room/presention/widgets/send_message_filed.dart';
import 'package:techmart/features/chat_room/utils/helper_funtions.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: custemAppbar(heading: "Customer Service", context: context),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<MessageBloc, MessageState>(
              listener: (context, state) {
                if (state is MessageFetched) {
                  scrollDown(state.scrollController);
                }
              },
              builder: (context, state) {
                if (state is LoadingState) {
                  return Text("Loading");
                }
                if (state is MessageFetched) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      controller: state.scrollController,
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        return MessageBubble(
                          userMessage: usercheck(message.senderId),
                          message: message.message,
                          time: message.time ?? DateTime.now(),
                        );
                      },
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
          BlocProvider(
            create: (context) => MessageCubit(),
            child: SendMessageField(),
          ),
        ],
      ),
    );
  }
}
