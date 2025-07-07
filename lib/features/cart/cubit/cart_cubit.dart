import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techmart/features/cart/model/product_cart_model.dart';
import 'package:techmart/features/cart/service/cart_service.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  StreamSubscription? _streamSubscription;
  CartCubit() : super(CartInitial());
  void fetchAllCart() {
    _streamSubscription?.cancel();
    _streamSubscription = CartService.fetchCart().listen(
      (cart) {
        if (cart.isEmpty) {
          emit(CartIsEmpty());
        } else if (cart.isNotEmpty) {
          emit(CartLoaded(cartItems: cart));
        }
      },
      onError: (error) {
        emit(CartErrorState(error: error));
      },
    );
  }

  Future<void> addToCart({
    required String productId,
    required String varientId,
    required int quatity,
    required String regularPrice,
    required String sellingPrice,
    required Map<String, String?> varientAttribute,
    required String imageurl,
    required String productName,
  }) async {
    final cartmodel = ProductCartModel(
      productName: productName,
      productId: productId,
      varientId: varientId,
      quatity: quatity,
      regularPrice: regularPrice,
      sellingPrice: sellingPrice,
      imageUrl: imageurl,
      varientAttribute: varientAttribute,
    );
    await CartService.addToCart(cartmodel);
  }

  void deleteFromCart(String cartId) {
    CartService.deleteProductFromCart(cartId);
  }

  void increaseQuatity(
    String cartId,
    String productId,
    String varientid,
  ) async {
    await CartService.increseQuatity(cartId, productId, varientid);
    emit(CartAdded());
  }

  void decreaseQuatity(String cartId) async {
    await CartService.decreaseQuantity(cartId);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
