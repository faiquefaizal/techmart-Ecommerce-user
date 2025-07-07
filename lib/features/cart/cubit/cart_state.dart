part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoaded extends CartState {
  List<ProductCartModel> cartItems;
  CartLoaded({required this.cartItems});

  bool isCartAdded(String varirntId, String ProductId) {
    return cartItems.any(
      (cartItems) =>
          cartItems.productId == ProductId && cartItems.varientId == varirntId,
    );
  }
}

final class CartIsEmpty extends CartState {}

final class CartErrorState extends CartState {
  String error;
  CartErrorState({required this.error});
}

final class CartAdded extends CartState {}
