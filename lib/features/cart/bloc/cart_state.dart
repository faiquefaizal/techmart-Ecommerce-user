part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class LoadingCart extends CartState {}

final class CartLoaded extends CartState {
  final List<ProductCartModel> cartItems;
  const CartLoaded({required this.cartItems});

  bool isCartAdded(String varirntId, String productId) {
    return cartItems.any(
      (cartItems) =>
          cartItems.productId == productId && cartItems.varientId == varirntId,
    );
  }

  @override
  List<Object> get props => [cartItems];
}

final class CartIsEmpty extends CartState {}

final class CartErrorState extends CartState {
  String error;
  CartErrorState({required this.error});
}

final class CartMinState extends CartLoaded {
  CartMinState({required List<ProductCartModel> cartItems})
    : super(cartItems: cartItems);
}

final class CartAdded extends CartState {}

final class CartMaxState extends CartLoaded {
  CartMaxState({required List<ProductCartModel> cartItems})
    : super(cartItems: cartItems);
}
