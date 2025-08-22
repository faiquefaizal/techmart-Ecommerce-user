part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

class LoadingState extends OrderState {}

class OrderLoaded extends OrderState {
  List<OrderModel> orderList;
  OrderLoaded(this.orderList);
}

class OrderPlacedSuccessfully extends OrderState {}

class OrderListIsEmpty extends OrderState {}

class Errorstate extends OrderState {
  String message;
  Errorstate(this.message);
}
