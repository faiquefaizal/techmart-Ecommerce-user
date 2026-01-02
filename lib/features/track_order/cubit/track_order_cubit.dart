import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techmart/features/orders/model/order_model.dart';
import 'package:techmart/features/track_order/service/track_order_service.dart';

part 'track_order_state.dart';

class TrackOrderCubit extends Cubit<TrackOrderState> {
  final TrackOrderService trackService;

  TrackOrderCubit(this.trackService) : super(TrackOrderInitial());

  Future<void> getOrderStatus(String orderId) async {
    try {
      await for (final order in trackService.fetchOrderDetails(orderId)) {
        emit(OrderTrackingState(order: order));
      }
    } catch (error) {
      emit(TrackOrderError(error.toString()));
    }
  }

  getOrderDetails(String id) async {
    try {
      emit(LoadingOrder());
      await Future.delayed(Duration(seconds: 3));
      final productModel = await trackService.fetchOrderDetailsOnce(id);
      final productDetails = await trackService.fetchPRoductInfo(
        productModel.productId,
        productModel.varientId,
      );
      emit(OrderDetails(order: productModel, productInfo: productDetails));
    } catch (e) {
      emit(TrackOrderError(e.toString()));
    }
  }
}
