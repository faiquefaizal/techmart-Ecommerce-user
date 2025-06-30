import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

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

  static Stream<List<ProductModel>> searchProduct(String quary) {
    if (quary.isEmpty) return getAllproducts();

    // final lowerQuary = quary.toLowerCase();
    return _productsRef
        .where("productName", isGreaterThanOrEqualTo: quary)
        .where("productName", isLessThanOrEqualTo: "$quary\uf8ff")
        .snapshots()
        .map(
          (snapshots) =>
              snapshots.docs
                  .map(
                    (docs) => ProductModel.fromMap(
                      docs.data() as Map<String, dynamic>,
                    ),
                  )
                  .toList(),
        );
  }

  static Stream<List<ProductModel>> searchWithRx(String query) async* {
    if (query.isEmpty) {
      yield* getAllproducts();
      return;
    }

    // final words = query.toLowerCase().split(' ');
    log("quary afternot empty chek");
    final words = query.split(' ');
    List<Stream<List<ProductModel>>> allStreams = [];

    for (String word in words) {
      // product name
      final nameStream = FirebaseFirestore.instance
          .collection('Products')
          .where('productName', isGreaterThanOrEqualTo: word)
          .where('productName', isLessThanOrEqualTo: '$word\uf8ff')
          .snapshots()
          .map(
            (snap) =>
                snap.docs.map((d) => ProductModel.fromMap(d.data())).toList(),
          );

      allStreams.add(nameStream);

      // brand
      final brandSnap =
          await FirebaseFirestore.instance
              .collection('Brands')
              .where('name', isEqualTo: word)
              .get();

      if (brandSnap.docs.isNotEmpty) {
        final brandId = brandSnap.docs.first.id;
        log("brandId printed");
        final brandStream = FirebaseFirestore.instance
            .collection('Products')
            .where('brandId', isEqualTo: brandId)
            .snapshots()
            .map(
              (snap) =>
                  snap.docs.map((d) => ProductModel.fromMap(d.data())).toList(),
            );

        allStreams.add(brandStream);
      }

      log(allStreams.toString());
      // category
      final catSnap =
          await FirebaseFirestore.instance
              .collection('Catagory')
              .where('Name', isEqualTo: word)
              .get();

      if (catSnap.docs.isNotEmpty) {
        final catId = catSnap.docs.first.id;

        final catStream = FirebaseFirestore.instance
            .collection('Products')
            .where('categoryId', isEqualTo: catId)
            .snapshots()
            .map(
              (snap) =>
                  snap.docs.map((d) => ProductModel.fromMap(d.data())).toList(),
            );

        allStreams.add(catStream);
      }
    }
    log(allStreams.length.toString());
    // Merge all product streams into one
    yield* Rx.combineLatestList(allStreams).map((listOfLists) {
      final allProducts =
          listOfLists
              .expand((list) => list)
              .toSet()
              .toList(); // remove duplicates
      return allProducts;
    });
  }
}
