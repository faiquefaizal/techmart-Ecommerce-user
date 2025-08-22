part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

final class FetchOrders extends OrderEvent {}

final class AddRating extends OrderEvent {
  final String id;
  final String message;
  final double count;
  const AddRating({
    required this.count,
    required this.id,
    required this.message,
  });
}
