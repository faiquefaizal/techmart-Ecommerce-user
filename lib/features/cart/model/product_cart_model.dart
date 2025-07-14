import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProductCartModel extends Equatable {
  String? cartId;
  String productId;
  String varientId;
  int quatity;
  String regularPrice;
  String sellingPrice;
  Map<String, String?> varientAttribute;
  Timestamp? createdtime;
  String imageUrl;
  String productName;
  int? availableStock;

  ProductCartModel({
    this.availableStock,
    required this.productName,
    required this.productId,
    required this.varientId,
    required this.quatity,
    required this.regularPrice,
    required this.sellingPrice,
    this.cartId,
    required this.varientAttribute,
    this.createdtime,
    required this.imageUrl,
  });

  ProductCartModel copyWith({
    String? productName,
    String? productId,
    String? varientId,
    int? quatity,
    String? regularPrice,
    String? sellingPrice,
    String? cartId,
    Map<String, String?>? varientAttribute,
    Timestamp? timeStamp,
    String? imageUrl,
    int? availableStock,
  }) {
    return ProductCartModel(
      availableStock: availableStock ?? this.availableStock,
      cartId: cartId ?? this.cartId,
      imageUrl: imageUrl ?? this.imageUrl,
      productId: productId ?? this.productId,
      varientId: varientId ?? this.varientId,
      quatity: quatity ?? this.quatity,
      regularPrice: regularPrice ?? this.regularPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      varientAttribute: varientAttribute ?? this.varientAttribute,
      createdtime: timeStamp ?? this.createdtime,
      productName: productName ?? this.productName,
    );
  }

  factory ProductCartModel.fromMap(Map<String, dynamic> map) {
    return ProductCartModel(
      availableStock: map["AvaliabelStock"],
      productName: map['productName'],
      cartId: map['cartId'],
      productId: map['productId'],
      varientId: map['varientId'],
      quatity: map['quatity'],
      regularPrice: map['regularPrice'],
      sellingPrice: map['sellingPrice'],
      varientAttribute: Map<String, String?>.from(map['varientAttribute']),
      createdtime: map['createdtime'],
      imageUrl: map["varientImage"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'cartId': cartId,
      "AvaliabelStock": availableStock,
      'productId': productId,
      'varientId': varientId,
      'quatity': quatity,
      'regularPrice': regularPrice,
      'sellingPrice': sellingPrice,
      'varientAttribute': varientAttribute,
      'createdtime': createdtime,
      "varientImage": imageUrl,
    };
  }

  @override
  List<Object> get props => [productId, varientId, quatity];
}
