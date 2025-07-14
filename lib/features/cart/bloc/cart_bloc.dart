import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techmart/features/cart/model/product_cart_model.dart';
import 'package:techmart/features/cart/service/cart_service.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  Logger logg = Logger();
  CartBloc() : super(CartInitial()) {
    on<FetchCart>(_onFetchCart);
    on<AddToCartEvent>(_onAddToCart);
    on<DeleteFromCartEvent>(_onDelete);
    on<IncreaseQtyEvent>(_onIncrease);
    on<DecreaseQtyEvent>(_onDecrease);
  }
  Future<void> _onFetchCart(FetchCart event, Emitter<CartState> emit) async {
    logg.t("oncartBloc triggered");

    emit(LoadingCart());
    logg.t("cartLoadingstate");
    try {
      logg.w("cart is gettin called");
      final cart = await CartService.fetchCartOnce();
      logg.w(cart.length);
      if (cart.isEmpty) {
        log("CartIsEmpty");
        emit(CartIsEmpty());
      } else {
        log("CartIsNotEmpty");
        emit(CartLoaded(cartItems: cart));
      }
    } catch (e) {
      emit(CartErrorState(error: e.toString()));
    }
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final currentState = state;
    if (currentState is CartLoaded) {
      final cartCheck = currentState.isCartAdded(
        event.cartModel.varientId,
        event.cartModel.productId,
      );
      if (cartCheck) {
        emit(CartErrorState(error: "ProductAlready Exist"));
        return;
      }
    }
    try {
      emit(CartAdded());
      await CartService.addToCart(
        event.cartModel,
        event.cartModel.productId,
        event.cartModel.varientId,
      );

      final cartItems = await CartService.fetchCartOnce();
      emit(CartLoaded(cartItems: cartItems));
    } catch (e) {
      emit(CartErrorState(error: e.toString()));
    }
  }

  Future<void> _onDelete(
    DeleteFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      await CartService.deleteProductFromCart(event.cartId);

      final cartItems = await CartService.fetchCartOnce();
      if (cartItems.isEmpty) {
        emit(CartIsEmpty());
      } else {
        emit(CartLoaded(cartItems: cartItems));
      }
    } catch (e) {
      emit(CartErrorState(error: e.toString()));
    }
  }

  Future<void> _onIncrease(
    IncreaseQtyEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      await CartService.increaseQuantity(event.cartModel);

      final cartItems = await CartService.fetchCartOnce();
      emit(
        cartItems.isEmpty ? CartIsEmpty() : CartLoaded(cartItems: cartItems),
      );
    } catch (e) {
      final error = e.toString();
      if (error.contains("Maximum cart quantity is 5.")) {
        emit(CartMaxState(cartItems: (state as CartLoaded).cartItems));
      } else if (error.contains("Cannot exceed available stock.")) {
        emit(CartErrorState(error: "Cannot exceed available stock."));
      } else {
        emit(CartErrorState(error: error));
      }
    }
  }

  Future<void> _onDecrease(
    DecreaseQtyEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      if (event.cartModel.quatity == 1) {
        if (state is CartLoaded) {
          emit(CartMinState(cartItems: (state as CartLoaded).cartItems));
        } else {
          emit(CartMinState(cartItems: []));
        }
        return;
      } else {
        await CartService.decreaseQuantity(event.cartModel.cartId!);
        final cartItems = await CartService.fetchCartOnce();
        emit(
          cartItems.isEmpty ? CartIsEmpty() : CartLoaded(cartItems: cartItems),
        );
      }
    } catch (e) {
      emit(CartErrorState(error: e.toString()));
    }
  }
}
