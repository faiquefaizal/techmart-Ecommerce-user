import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techmart/features/orders/model/order_model.dart';

class TrackOrderService {
  final CollectionReference orderCollection = FirebaseFirestore.instance
      .collection("Orders");
  final CollectionReference product = FirebaseFirestore.instance.collection(
    "Products",
  );
  Stream<OrderModel> fetchOrderDetails(String id) {
    final orderDoc = orderCollection.doc(id).snapshots();
    return orderDoc.map(
      (orderDoc) =>
          OrderModel.fromJson(orderDoc.data() as Map<String, dynamic>),
    );
  }

  Future<Map<String, String>> fetchPRoductNameAndImage(
    String id,
    String varientId,
  ) async {
    assert(id.isNotEmpty && varientId.isNotEmpty, "imput is empty");
    try {
      final productDoc = await product.doc(id).get();
      if (!productDoc.exists) {
        log("Product document does not exist");
        return {};
      }
      log("varient id ${varientId.toString()}");
      final varientDoc =
          await product.doc(id).collection("varients").doc(varientId).get();
      if (!varientDoc.exists) {
        log("Variant document does not exist");
      }
      log("varinet id ${varientId.toString()}");
      final productName = productDoc.get("productName");
      final productImage = (varientDoc.get("variantImageUrls"));
      final productImageitem = (productImage as List).first.toString();
      log("product imge${productImageitem.toString()}");
      log("product name${productName.toString()}");
      if (!productDoc.exists || !varientDoc.exists) {
        log("doesnot exist");
        log(productDoc.toString());
        log(varientDoc.toString());
        return {};
      }
      return {"ProductName": productName, "image": productImageitem};
    } catch (e) {
      log("main funitonerre${e.toString()}");
      rethrow;
    }
  }

  Future<OrderModel> fetchOrderDetailsOnce(String id) async {
    final orderDoc = await orderCollection.doc(id).get();
    return OrderModel.fromJson(orderDoc.data() as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> fetchPRoductInfo(
    String id,
    String varientId,
  ) async {
    assert(id.isNotEmpty && varientId.isNotEmpty, "imput is empty");
    try {
      final productDoc = await product.doc(id).get();
      if (!productDoc.exists) {
        log("Product document does not exist");
        return {};
      }
      log("varient id ${varientId.toString()}");
      final varientDoc =
          await product.doc(id).collection("varients").doc(varientId).get();
      if (!varientDoc.exists) {
        log("Variant document does not exist");
      }
      log("varinet id ${varientId.toString()}");
      final productName = productDoc.get("productName");
      final productImage = (varientDoc.get("variantImageUrls"));
      final productImageitem = (productImage as List).first.toString();
      log("product imge${productImageitem.toString()}");
      log("product name${productName.toString()}");
      if (!productDoc.exists || !varientDoc.exists) {
        log("doesnot exist");
        log(productDoc.toString());
        log(varientDoc.toString());
        return {};
      }
      final productattributes = varientDoc.get("variantAttributes");
      return {
        "Name": productName,
        "Image": productImageitem,
        "varientAttributes": productattributes,
      };
    } catch (e) {
      log("main funitonerre${e.toString()}");
      rethrow;
    }
  }
}
