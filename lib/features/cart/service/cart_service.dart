import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techmart/core/utils/genrete_firbase_id.dart';
import 'package:techmart/features/authentication/service/Auth_service.dart';
import 'package:techmart/features/cart/bloc/cart_bloc.dart';
import 'package:techmart/features/cart/model/product_cart_model.dart';

class CartService {
  static CollectionReference get _cartRef {
    final userId = AuthService().getUserId() ?? "hello";
    log(userId);
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .collection("Cart");
  }

  static Future<void> addToCart(
    ProductCartModel cartModel,
    String productId,
    String varientId,
  ) async {
    final cartId = genertateFirebase();
    final availabelCount = await getVarientQuatityFromVarientId(
      productId,
      varientId,
    );
    log("cartIdjust after th efuntion $cartId");

    final newCartProduct = cartModel.copyWith(
      availableStock: availabelCount,
      cartId: cartId,
      timeStamp: Timestamp.fromDate(DateTime.now()),
    );
    log("new cartId ${newCartProduct.cartId!}");
    await _cartRef.doc(newCartProduct.cartId).set(newCartProduct.toMap());
  }

  static Future<void> deleteProductFromCart(String? cartId) async {
    if (cartId == null || cartId.isEmpty) {
      throw Exception(" cartID $cartId cant be empty");
    }
    try {
      await _cartRef.doc(cartId).delete();
    } catch (e) {
      log("delete Error ${e.toString()}");
    }
  }

  static Stream<List<ProductCartModel>> fetchCart() {
    final cartSnap = _cartRef.snapshots();
    return cartSnap.map(
      (snaps) =>
          snaps.docs
              .map(
                (doc) => ProductCartModel.fromMap(
                  doc.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
    );
  }

  // static Future<void> increseQuatity(
  //   String? cartId,
  //   String productId,
  //   String varientId,
  // ) async {
  //   final currentVarientCount = await getVarientQuatityFromVarientId(
  //     productId,
  //     varientId,
  //   );
  //   if (cartId == null || cartId.isEmpty) {
  //     throw Exception(" cartID $cartId cant be empty");
  //   }
  //   final cartRef = _cartRef.doc(cartId);
  //   final cartData = await cartRef.get();

  //   if (cartData.exists) {
  //     if (cartData["quatity"] < currentVarientCount) {
  //       await cartRef.update({"quatity": FieldValue.increment(1)});
  //       return;
  //     } else if (cartData["quatity"] == currentVarientCount) {
  //       throw Exception("cant increases cart quatuty above th available Stock");
  //     } else if (cartData["quatity"] > currentVarientCount) {
  //       throw Exception();
  //     }
  //   }
  // }

  static decreaseQuantity(String cartId) async {
    final docRef = _cartRef.doc(cartId);
    final cartsnap = await docRef.get();
    if (cartId.isEmpty) {
      throw Exception("Cart ID cannot be empty.");
    }

    if (cartsnap.exists) {
      final currentqty =
          (cartsnap.data() as Map<String, dynamic>)["quatity"] ?? 0;
      if (currentqty > 1) {
        await docRef.update({"quatity": FieldValue.increment(-1)});
      } else {
        throw Exception("Minimum quantity is 1.");
      }
    }
  }

  static Future<int> getVarientQuatityFromVarientId(
    String productId,
    String varientId,
  ) async {
    final vareintDocRef =
        await FirebaseFirestore.instance
            .collection("Products")
            .doc(productId)
            .collection("varients")
            .doc(varientId)
            .get();
    if (vareintDocRef.exists) {
      return vareintDocRef.data()?["quantity"] as int;
    } else {
      throw Exception("vairnrt not exist");
    }
  }

  static Future<List<ProductCartModel>> fetchCartOnce() async {
    final cartDef = await _cartRef.get();
    return cartDef.docs
        .map((e) => ProductCartModel.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }

  static Future<void> increaseQuantity(ProductCartModel cartItem) async {
    final cartRef = _cartRef.doc(cartItem.cartId);
    final currentQty = cartItem.quatity;
    final availableStock = cartItem.availableStock ?? 0;

    if (currentQty >= 5) {
      throw Exception("Maximum cart quantity is 5.");
    }

    if (currentQty >= availableStock) {
      throw Exception("Cannot exceed available stock.");
    }

    await cartRef.update({"quatity": FieldValue.increment(1)});
  }

  static Future<bool> checkIfPRoductExistInCart(
    String productId,
    String varientId,
  ) async {
    final cartRef = _cartRef
        .where("productId", isEqualTo: productId)
        .where("varientId", isEqualTo: varientId);
    final cartDoc = await cartRef.get();
    if (cartDoc.docs.isNotEmpty) {
      return true;
    }
    return false;
  }
}
