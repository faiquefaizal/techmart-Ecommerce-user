import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageEmpty());
  checkMessage(String message) {
    if (message.isEmpty) {
      log(MessageEmpty().toString());
      emit(MessageEmpty());
    }
    emit(MessageNonEmpty());
  }
}
