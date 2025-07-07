import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techmart/core/utils/genrete_firbase_id.dart';
import 'package:techmart/features/authentication/service/Auth_service.dart';
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

  static Future<void> addToCart(ProductCartModel cartModel) async {
    final cartId = genertateFirebase();
    final newCartProduct = cartModel.copyWith(
      cartId: cartId,
      timeStamp: Timestamp.fromDate(DateTime.now()),
    );
    await _cartRef.doc(newCartProduct.cartId).set(newCartProduct.toMap());
  }

  static Future<void> deleteProductFromCart(String cartId) async {
    try {
      await _cartRef.doc(cartId).delete();
    } catch (e) {
      log(e.toString());
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

  static Future<void> increseQuatity(
    String cartId,
    String ProductId,
    String varientId,
  ) async {
    final currentVarientCount = await getVarientQuatityFromVarientId(
      ProductId,
      varientId,
    );
    final cartRef = _cartRef.doc(cartId);
    final cartData = await cartRef.get();

    if (cartData.exists) {
      if (cartData["quatity"] < currentVarientCount) {
        await cartRef.update({"quatity": FieldValue.increment(1)});
      } else if (cartData["quatity"] == currentVarientCount) {
        throw Exception("cant increases cart quatuty above th available Stock");
      } else if (cartData["quatity"] > currentVarientCount) {
        throw Exception();
      }
    }
  }

  static decreaseQuantity(String cartId) async {
    final docRef = _cartRef.doc(cartId);
    final cartsnap = await docRef.get();

    if (cartsnap.exists) {
      final currentqty =
          (cartsnap.data() as Map<String, dynamic>)["quatity"] ?? 0;
      if (currentqty > 1) {
        await docRef.update({"quatity": FieldValue.increment(-1)});
      } else {
        await docRef.delete();
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
}
