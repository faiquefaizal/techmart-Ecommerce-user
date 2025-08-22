part of 'track_order_cubit.dart';

sealed class TrackOrderState extends Equatable {
  const TrackOrderState();

  @override
  List<Object> get props => [];
}

final class TrackOrderInitial extends TrackOrderState {}

final class LoadingOrder extends TrackOrderState {}

final class OrderDetails extends TrackOrderState {
  final OrderModel order;
  final Map<String, dynamic> productInfo;

  const OrderDetails({required this.order, required this.productInfo});
}

final class OrderTrackingState extends TrackOrderState {
  final OrderModel order;

  const OrderTrackingState({required this.order});
  @override
  List<Object> get props => [order];
}

final class TrackOrderError extends TrackOrderState {
  final String message;
  const TrackOrderError(this.message);
}
