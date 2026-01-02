part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class PlaceOnlineOrder extends OrderEvent {
  final List<ProductCartModel> cartList;
  final AddressModel address;
  final int total;
  final String deliverycharge;
  final String? coupenCode;

  const PlaceOnlineOrder({
    required this.address,
    required this.cartList,
    required this.total,
    required this.deliverycharge,
    this.coupenCode,
  });
}

class PlaceOrderCod extends OrderEvent {
  final List<ProductCartModel> cartList;
  final AddressModel address;
  final int total;
  final String deliverycharge;
  final String? coupenCode;

  const PlaceOrderCod({
    required this.address,
    required this.cartList,
    required this.total,
    required this.deliverycharge,
    this.coupenCode,
  });
}

class FetchOrders extends OrderEvent {}

class ClearOrder extends OrderEvent {}
