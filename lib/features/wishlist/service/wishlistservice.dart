import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techmart/core/utils/genrete_firbase_id.dart';

import 'package:techmart/features/authentication/service/Auth_service.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';

import 'package:techmart/features/wishlist/model/wish_list_model.dart';

class WishlistService {
  static final CollectionReference _productsRef = FirebaseFirestore.instance
      .collection("Products");
  static CollectionReference<Map<String, dynamic>> get _wishlistRef {
    final userId = AuthService().getUserId();
    log(userId ?? "not printes");
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .collection("wishlist");
  }

  static void addWishList(String productId, String varientId) {
    final wishlistId = genertateFirebase();
    log(wishlistId.toString());
    final wishlistmodel = WishListModel(
      productId: productId,
      varientId: varientId,
      wishlistId: wishlistId,
      createdtime: Timestamp.fromDate(DateTime.now()),
    );
    _wishlistRef.doc(wishlistId).set(wishlistmodel.toMap());
  }

  static delete(String wishistId) {
    _wishlistRef.doc(wishistId).delete();
  }

  static Stream<List<WishListModel>> getAllWishList() {
    final docSnaps = _wishlistRef.snapshots();
    return docSnaps.map(
      (docs) =>
          (docs.docs).map((doc) => WishListModel.frommap(doc.data())).toList(),
    );
  }

  static Future<String?> checkifProductExistInWishList(
    String productId,
    String varientId,
  ) async {
    final wishList =
        await _wishlistRef
            .where("productId", isEqualTo: productId)
            .where("varientId", isEqualTo: varientId)
            .get();
    if (wishList.docs.isNotEmpty) {
      return wishList.docs.first.data()["wishlistId"];
    } else if (wishList.docs.isNotEmpty) {
      return null;
    }
  }

  static Future<ProductModel?> getProductFromId(String productId) async {
    final snap =
        await _productsRef
            .where("productId", isEqualTo: productId)
            .limit(1)
            .get();
    if (snap.docs.isNotEmpty) {
      return snap.docs
          .map(
            (doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>),
          )
          .first;
    }
    return null;
  }
}
