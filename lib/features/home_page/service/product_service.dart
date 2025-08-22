import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techmart/features/home_page/features/product_filter/cubit/filter_cubit.dart';
import 'package:techmart/features/home_page/features/product_filter/model/price_sort_enum.dart';
import 'package:techmart/features/home_page/models/brand_model.dart';

import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';

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
        rethrow;
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

    final freeQuary = query;

    final fullPhraseSnapshot =
        await FirebaseFirestore.instance
            .collection('Products')
            .where('productName', isGreaterThanOrEqualTo: freeQuary)
            .where('productName', isLessThanOrEqualTo: '$freeQuary\uf8ff')
            .get();

    if (fullPhraseSnapshot.docs.isNotEmpty) {
      yield fullPhraseSnapshot.docs
          .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      return;
    }
    final words = freeQuary.split(' ').where((v) => v.isNotEmpty);
    log("quary afternot empty chek");
    // final words = query.split(' ');
    List<Stream<List<ProductModel>>> allStreams = [];

    for (String word in words) {
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

    yield* Rx.combineLatestList(allStreams).map((listOfLists) {
      final allProducts = listOfLists.expand((list) => list).toSet().toList();
      return allProducts;
    });
  }

  static Future<List<BrandModel>> fetchBrands() async {
    final brandDoc = await brandsRef.get();
    log(brandDoc.docs.toString());
    return brandDoc.docs.map((doc) => BrandModel.fromMap(doc.data())).toList();
  }

  static Future<List<ProductVarientModel>> getVariantsForProduct(
    String productID,
  ) async {
    final varinetDoc =
        await _productsRef.doc(productID).collection("varients").get();
    return varinetDoc.docs
        .map((doc) => ProductVarientModel.fromMap(doc.data()))
        .toList();
  }

  static Stream<List<ProductModel>> filterProdoct(FilterState filerState) {
    Query quary = _productsRef;
    Logger().w(filerState.sortBy);
    if (filerState.selectedBrandId != "") {
      quary = quary.where("brandId", isEqualTo: filerState.selectedBrandId);
    }
    if (filerState.priceRange != null) {
      quary = quary
          .where(
            "minPrice",
            isGreaterThanOrEqualTo: filerState.priceRange.start,
          )
          .where("maxPrice", isLessThanOrEqualTo: filerState.priceRange.end);
    }
    if (filerState.sortBy != null) {
      switch (filerState.sortBy!) {
        case PriceSort.lowToHigh:
          quary = quary.orderBy("minPrice", descending: false);
          quary.snapshots().listen((snapshot) {
            final products =
                snapshot.docs
                    .map(
                      (doc) => ProductModel.fromMap(
                        doc.data() as Map<String, dynamic>,
                      ),
                    )
                    .toList();
            Logger().i(
              "low to high  ${products.map((e) => e.minPrice).toList()}",
            );
          });
          return quary.snapshots().map((snapshot) {
            final products =
                snapshot.docs
                    .map(
                      (doc) => ProductModel.fromMap(
                        doc.data() as Map<String, dynamic>,
                      ),
                    )
                    .toList();
            for (var product in products) {
              Logger().w(
                "productName ${product.productId} minPrice${product.minPrice}   ",
              );
            }
            return products;
          });

        case PriceSort.highToLow:
          quary = quary.orderBy("minPrice", descending: true);

          quary.snapshots().listen((snapshot) {
            final products =
                snapshot.docs
                    .map(
                      (doc) => ProductModel.fromMap(
                        doc.data() as Map<String, dynamic>,
                      ),
                    )
                    .toList();
            Logger().e(
              "high to low  ${products.map((e) => e.minPrice).toList()}",
            );
          });
          return quary.snapshots().map((snapshot) {
            log("switchreturn entered");
            final products =
                snapshot.docs
                    .map(
                      (doc) => ProductModel.fromMap(
                        doc.data() as Map<String, dynamic>,
                      ),
                    )
                    .toList();
            for (var product in products) {
              Logger().w(
                "productName ${product.productId} minPrice${product.minPrice}   ",
              );
            }
            return products;
          });
      }
    }
    return quary.snapshots().map((snapshot) {
      return snapshot.docs
          .map(
            (doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>),
          )
          .toList();
    });
  }

  static Stream<List<ProductModel>> searchAndFilter({
    String? query,
    FilterState? filter,
  }) async* {
    // Logger().e(" search query: '$query'");
    // Logger().e(" brand filter: '${filter?.selectedBrandId ?? "null"}");
    // Logger().e(
    //   " price range: ₹${filter!.priceRange.start} - ₹${filter.priceRange.end}",
    // );
    // Logger().e("↕sort: ${filter.sortBy}");

    if (query == null && filter != null) {
      yield* filterProdoct(filter);
      return;
    }
    if (filter == null && query != null || query == null && filter == null) {
      yield* searchWithRx(query ?? "");
      return;
    } else {
      final searchStream = searchWithRx(query!);
      final filterStream = filterProdoct(filter!);

      yield* Rx.combineLatest2(searchStream, filterStream, (
        List<ProductModel> searchList,
        List<ProductModel> filterList,
      ) {
        final searchIds = searchList.map((e) => e.productId).toSet();
        final merged =
            filterList.where((p) => searchIds.contains(p.productId)).toList();

        log("Combined Search + Filter → ${merged.length} products:");
        for (var p in merged) {
          log("${p.productId} | ${p.productName} | ₹${p.minPrice}");
        }
        return merged;
      });
    }
  }
}
