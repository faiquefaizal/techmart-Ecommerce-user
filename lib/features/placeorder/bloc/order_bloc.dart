import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techmart/features/address/models/address_model.dart';
import 'package:techmart/features/cart/model/product_cart_model.dart';

import 'package:techmart/features/orders/model/order_model.dart';
import 'package:techmart/features/payments/const/payment.dart';
import 'package:techmart/features/placeorder/service/place_order_service.dart';
import 'package:techmart/features/payments/service/payment_service.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  PlaceOrderService orderService;
  OrderBloc(this.orderService) : super(OrderInitial()) {
    on<PlaceOnlineOrder>(_placeOrderOnline);
    on<PlaceOrderCod>(_placeOrderCod);
  }
  _placeOrderOnline(PlaceOnlineOrder event, Emitter<OrderState> emit) async {
    emit(LoadingState());
    try {
      final neededthing = secretkey ?? "null";
      log(neededthing);
      log("place online paymetn called");
      final paymentId = await PaymentService().makePayment(event.total);
      log("paymentId $paymentId");
      await orderService.placeOrderWithStripe(
        cartList: event.cartList,
        address: event.address,
        total: event.total,
        paymentId: paymentId,
        deliverycharge: event.deliverycharge,
        coupenCode: event.coupenCode,
      );

      emit(OrderPlacedSuccessfully());
    } catch (e) {
      log("catch error");
      log(e.toString());
      emit(Errorstate(e.toString()));
    }
  }

  _placeOrderCod(PlaceOrderCod event, Emitter<OrderState> emit) async {
    emit(LoadingState());
    await Future.delayed(Duration(seconds: 2));
    try {
      await orderService.placeOrderCod(
        cartList: event.cartList,
        address: event.address,
        total: event.total,
        deliverycharge: event.deliverycharge,
        coupenCode: event.coupenCode,
      );

      emit(OrderPlacedSuccessfully());
    } catch (e) {
      log(e.toString());
      emit(Errorstate(e.toString()));
    }
  }
}
