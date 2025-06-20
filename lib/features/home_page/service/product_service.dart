import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:techmart/features/home_page/models/peoduct_model.dart';

class ProductService {
  static CollectionReference _productsRef = FirebaseFirestore.instance
      .collection("Products");
  static final brandsRef = FirebaseFirestore.instance.collection("Brands");
  static Stream<List<ProductModel>> getAllproducts() {
    return _productsRef.snapshots().map((snapshot) {
      try {
        return snapshot.docs
            .map(
              (doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>),
            )
            .toList();
      } catch (e) {
        log("Error mapping products: $e");
        throw e; // so StreamBuilder sees the error
      }
    });
  }

  static Future<String> getBrandNameById(String id) async {
    return await brandsRef.doc(id).get().then((doc) => doc["name"]);
  }
}
