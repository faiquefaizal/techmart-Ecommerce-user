import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techmart/features/orders/model/order_card_model.dart';
import 'package:techmart/features/orders/model/order_model.dart';
import 'package:techmart/features/orders/service/order_service.dart';
import 'package:techmart/features/orders/utils/order_card_util.dart';

part 'order_event.dart';
part 'order_state.dart';

class FetchOrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderService orderService;
  StreamSubscription? _streamSubscription;

  FetchOrderBloc(this.orderService) : super(OrderInitial()) {
    on<FetchOrders>(_onFetchOrders);
    on<AddRating>(_addRating);
  }

  _onFetchOrders(FetchOrders event, Emitter<OrderState> emit) async {
    emit(OrderLoading());

    await emit.forEach<List<OrderModel>>(
      orderService.fetchOrders(),
      onData: (allOrders) {
        if (allOrders.isEmpty) {
          emit(EmptyOrders());
        }
        log(allOrders.length.toString());
        assert(allOrders.isNotEmpty, "orderiteselfisempty");
        final upcoming =
            allOrders.where((o) => o.status != "delivery").toList();

        final completed =
            allOrders.where((o) => o.status == "delivery").toList();

        return OrderLoaded(
          upcomingOrders: upcoming,
          completedOrders: completed,
        );
      },
      onError: (error, stackTrace) => OrderError(error.toString()),
    );
  }

  _addRating(AddRating event, Emitter<OrderState> emit) async {
    await orderService.addRating(event.id, event.count, event.message);
  }
}
