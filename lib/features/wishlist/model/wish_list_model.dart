import 'package:cloud_firestore/cloud_firestore.dart';

class WishListModel {
  String productId;
  String varientId;
  Timestamp? createdtime;
  String? wishlistId;
  WishListModel({
    required this.productId,
    required this.varientId,
    this.createdtime,
    this.wishlistId,
  });

  WishListModel copyWith({
    String? productId,
    String? varientId,
    Timestamp? createdtime,
    String? wishlistId,
  }) {
    return WishListModel(
      productId: productId ?? this.productId,
      varientId: varientId ?? this.varientId,
      createdtime: createdtime ?? this.createdtime,
      wishlistId: wishlistId ?? this.wishlistId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "productId": productId,
      "varientId": varientId,
      "createdtime": createdtime,
      "wishlistId": wishlistId,
    };
  }

  factory WishListModel.frommap(Map<String, dynamic> map) {
    return WishListModel(
      productId: map["productId"],
      varientId: map["varientId"],
      createdtime: map["createdtime"],
      wishlistId: map["wishlistId"],
    );
  }
}
