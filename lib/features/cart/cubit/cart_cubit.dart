// import 'dart:async';
// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:techmart/features/cart/model/product_cart_model.dart';
// import 'package:techmart/features/cart/service/cart_service.dart';

// part 'cart_state.dart';

// class CartCubit extends Cubit<CartState> {
//   StreamSubscription? _streamSubscription;
//   CartCubit() : super(CartInitial());
//   void fetchAllCart() {
//     _streamSubscription?.cancel();
//     _streamSubscription = CartService.fetchCart().listen(
//       (cart) {
//         log(
//           "Cart updated from Firestore: ${cart.map((e) => e.quatity).toList()}",
//         );
//         if (cart.isEmpty) {
//           emit(CartIsEmpty());
//         } else if (cart.isNotEmpty) {
//           emit(CartLoaded(cartItems: cart));
//         }
//       },
//       onError: (error) {
//         emit(CartErrorState(error: error));
//       },
//     );
//   }

//   Future<void> addToCart({
//     required String productId,
//     required String varientId,
//     required int quatity,
//     required String regularPrice,
//     required String sellingPrice,
//     required Map<String, String?> varientAttribute,
//     required String imageurl,
//     required String productName,
//   }) async {
//     final cartmodel = ProductCartModel(
//       productName: productName,
//       productId: productId,
//       varientId: varientId,
//       quatity: quatity,
//       regularPrice: regularPrice,
//       sellingPrice: sellingPrice,
//       imageUrl: imageurl,
//       varientAttribute: varientAttribute,
//     );

//     await CartService.addToCart(cartmodel);

//     emit(CartAdded());
//     fetchAllCart();
//   }

//   void deleteFromCart(String? cartId) {
//     if (cartId?.isEmpty ?? false || cartId == null) {
//       throw Exception("cartID $cartId cant be emoty");
//     }
//     CartService.deleteProductFromCart(cartId);
//   }

//   void increaseQuatity(
//     String? cartId,
//     String productId,
//     String varientid,
//     int quatity,
//   ) async {
//     try {
//       if (quatity >= 5) {
//         final List<ProductCartModel> currentItems =
//             (state is CartLoaded) ? (state as CartLoaded).cartItems : [];
//         emit(CartMaxState(cartItems: currentItems));
//         return;
//       }
//       await CartService.increseQuatity(cartId, productId, varientid);
//     } catch (e) {
//       log("incerreaseQatityError ${e.toString()}");
//       emit(CartErrorState(error: e.toString()));
//     }
//   }

//   void decreaseQuatity(ProductCartModel cartModel) async {
//     final currentCount = cartModel.quatity;
//     log("count ${currentCount.toString()}");

//     if (currentCount == 1) {
//       final List<ProductCartModel> currentItems =
//           (state is CartLoaded) ? (state as CartLoaded).cartItems : [];
//       emit(CartMinState(cartItems: currentItems));
//       return;
//     }
//     await CartService.decreaseQuantity(cartModel.cartId!);
//   }

//   @override
//   Future<void> close() {
//     _streamSubscription?.cancel();
//     return super.close();
//   }
// }
