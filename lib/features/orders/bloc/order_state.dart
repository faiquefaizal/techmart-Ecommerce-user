part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class EmptyOrders extends OrderState {}

final class OrderLoaded extends OrderState {
  final List<OrderModel> upcomingOrders;
  final List<OrderModel> completedOrders;

  const OrderLoaded({
    required this.upcomingOrders,
    required this.completedOrders,
  });

  @override
  List<Object> get props => [upcomingOrders, completedOrders];
}

final class OrderError extends OrderState {
  final String message;
  const OrderError(this.message);

  @override
  List<Object> get props => [message];
}
