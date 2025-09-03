part of 'message_bloc.dart';

sealed class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

final class MessageInitial extends MessageState {}

final class MessageFetched extends MessageState {
  final ScrollController scrollController;
  final FocusNode nodeController;
  final TextEditingController messageController;
  final List<MessageModel> messages;
  const MessageFetched(
    this.messageController,
    this.messages,
    this.scrollController,
    this.nodeController,
  );
  @override
  List<Object> get props => [messages];
}

final class LoadingState extends MessageState {}
