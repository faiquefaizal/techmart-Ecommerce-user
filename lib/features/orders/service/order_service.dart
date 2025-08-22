import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techmart/features/authentication/service/Auth_service.dart';
import 'package:techmart/features/orders/model/order_model.dart';
import 'package:techmart/features/placeorder/bloc/order_bloc.dart';

class OrderService {
  final CollectionReference _orderRef = FirebaseFirestore.instance.collection(
    "Orders",
  );
  final CollectionReference product = FirebaseFirestore.instance.collection(
    "Products",
  );
  String? get userId {
    final userId = AuthService().getUserId();
    if (userId != null) {
      return userId;
    }
    return null;
  }

  Stream<List<OrderModel>> fetchOrders() {
    if (userId == null) {
      throw Exception("User not logged in !");
    }
    try {
      final orderDocs =
          _orderRef
              .where("userId", isEqualTo: userId)
              .orderBy("createTime")
              .snapshots();

      return orderDocs.map(
        (snapshot) =>
            snapshot.docs.map((doc) {
              return OrderModel.fromJson(doc.data() as Map<String, dynamic>);
            }).toList(),
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchPRoductDetails(
    String id,
    String varientId,
  ) async {
    try {
      final productDoc = await product.doc(id).get();
      final varientDoc =
          await product.doc(id).collection("varients").doc(varientId).get();

      log("varientId${varientId.toString()}");
      log("id${id.toString()}");
      final productName = productDoc.get("productName");
      final productImage = (varientDoc.get("variantImageUrls"));
      final productImageitem = (productImage as List).first.toString();
      final varientAttributes = varientDoc.get("variantAttributes");

      return {
        "ProductName": productName,
        "image": productImageitem,
        "attributes": varientAttributes,
      };
    } catch (e) {
      log("FetchProductDertails ${e.toString()}");
      rethrow;
    }
  }
  // Stream<List<OrderModel>> fetchOrdersByStatuses() {
  //   if (userId == null) throw Exception("User not logged in!");

  //   final orderDocs =
  //       _orderRef
  //           .where("userId", isEqualTo: userId)
  //           .where(
  //             "status",
  //             whereIn: ["delivery", "returned", "returnRequested "],
  //           )
  //           .orderBy("createTime", descending: true)
  //           .snapshots();

  //   return orderDocs.map(
  //     (snapshot) =>
  //         snapshot.docs
  //             .map(
  //               (doc) =>
  //                   OrderModel.fromJson(doc.data() as Map<String, dynamic>),
  //             )
  //             .toList(),
  //   );
  // }

  addRating(String id, double ratingCount, String ratingText) async {
    await _orderRef.doc(id).update({
      "rating": ratingCount,
      "ratingText": ratingText,
    });
  }
}
