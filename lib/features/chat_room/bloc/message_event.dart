part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

final class FetchMessages extends MessageEvent {
  const FetchMessages();
}

final class SendMessage extends MessageEvent {
  final String message;
  const SendMessage(this.message);
}
