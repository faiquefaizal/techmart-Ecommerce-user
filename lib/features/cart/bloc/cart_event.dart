part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class FetchCart extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final ProductCartModel cartModel;

  const AddToCartEvent({required this.cartModel});
}

class DeleteFromCartEvent extends CartEvent {
  final String cartId;
  const DeleteFromCartEvent(this.cartId);
}

class IncreaseQtyEvent extends CartEvent {
  final ProductCartModel cartModel;
  const IncreaseQtyEvent(this.cartModel);
}

class DecreaseQtyEvent extends CartEvent {
  final ProductCartModel cartModel;
  const DecreaseQtyEvent(this.cartModel);
}
