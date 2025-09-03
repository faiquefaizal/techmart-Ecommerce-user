import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:techmart/features/chat_room/models/message_model.dart';
import 'package:techmart/features/chat_room/service/chat_room_service.dart';
import 'package:techmart/features/chat_room/utils/helper_funtions.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  TextEditingController messageController;
  String recieverId;
  ChatRoomService service;
  ScrollController scrollController;
  FocusNode focusNode;
  MessageBloc(
    this.messageController,
    this.recieverId,
    this.service,
    this.scrollController,
    this.focusNode,
  ) : super(MessageInitial()) {
    on<MessageEvent>(_messageEvent);
    on<SendMessage>(_sendmessageEvent);

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Logger().w("called in loop");
        scrollDown(scrollController);
      }
      Logger().w("without loop");
    });
  }
  _messageEvent(MessageEvent event, Emitter<MessageState> emit) async {
    await emit.forEach(
      service.fetchMessages(recieverId),
      onData: (messages) {
        return MessageFetched(
          messageController,
          messages,
          scrollController,
          focusNode,
        );
      },
    );
  }

  _sendmessageEvent(SendMessage event, Emitter<MessageState> emit) async {
    messageController.clear();
    await service.sendMessage(recieverId, event.message);
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    focusNode.dispose();
    messageController.dispose();
    return super.close();
  }
}
