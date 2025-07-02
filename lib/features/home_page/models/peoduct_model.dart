import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';

class ProductModel extends Equatable {
  String productId;
  String productName;
  String productDescription;
  String sellerUid;
  String categoryId;
  String brandId;

  ProductModel({
    required this.productId,
    required this.brandId,
    required this.categoryId,

    required this.productDescription,
    required this.productName,
    required this.sellerUid,
  });

  Map<String, dynamic> toMap() {
    return {
      "productId": productId,
      "productName": productName,
      "productDescription": productDescription,
      "sellerUid": sellerUid,
      "brandId": brandId,
      "categoryId": categoryId,
    };
  }

  @override
  List<Object> get props => [productId];

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    log("recieved productMap${map.toString()}");
    return ProductModel(
      productId: map["productId"] ?? "",
      brandId: map["brandId"],
      categoryId: map["categoryId"],
      // imageUrls: (map["imageUrls"] as List?)?.map((e) => e.toString()).toList(),
      productDescription: map["productDescription"],
      productName: map["productName"],
      sellerUid: map["sellerUid"],
      // varients:
      //     (map["varients"] as List<dynamic>?)
      //         ?.map(
      //           (e) => ProductVarientModel.fromMap(e as Map<String, dynamic>),
      //         )
      //         .toList() ??
      //     [],
    );
  }
  @override
  String toString() {
    return '''
ProductModel(
productId:$productId,
  brandId: $brandId,
  categoryId: $categoryId,
  productDescription: $productDescription,
  productName: $productName,
  sellerUid: $sellerUid,

)''';
  }

  ProductModel copyWith({
    String? productId,
    String? productName,
    String? productDescription,
    String? sellerUid,
    String? categoryId,
    String? brandId,

    // List<String>? imageUrls, // Uncomment this if you start using imageUrls
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      sellerUid: sellerUid ?? this.sellerUid,
      categoryId: categoryId ?? this.categoryId,
      brandId: brandId ?? this.brandId,

      // imageUrls: imageUrls ?? this.imageUrls, // Uncomment this if you start using imageUrls
    );
  }
}
