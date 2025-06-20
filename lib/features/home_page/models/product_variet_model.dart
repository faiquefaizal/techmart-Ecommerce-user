import 'dart:developer';

class ProductVarientModel {
  Map<String, String?> variantAttributes;
  int quantity;
  int regularPrice;
  int sellingPrice;
  int buyingPrice;
  List<String>? variantImageUrls;

  ProductVarientModel({
    required this.buyingPrice,
    required this.quantity,
    required this.regularPrice,
    required this.sellingPrice,
    required this.variantAttributes,
    this.variantImageUrls,
  });

  Map<String, dynamic> toMap() {
    return {
      "variantAttributes": variantAttributes,
      "quantity": quantity,
      "regularPrice": regularPrice,
      "sellingPrice": sellingPrice,
      "buyingPrice": buyingPrice,
      "variantImageUrls": variantImageUrls, // <--- ADDED TO toMap()
    };
  }

  factory ProductVarientModel.fromMap(Map<String, dynamic> map) {
    log('Variant Map: $map');
    return ProductVarientModel(
      buyingPrice: map["buyingPrice"],
      quantity: map["quantity"],
      regularPrice: map["regularPrice"],
      sellingPrice: map["sellingPrice"],
      variantAttributes: Map<String, String>.from(
        map["variantAttributes"] ?? {},
      ),
      variantImageUrls:
          (map["variantImageUrls"] as List?)?.map((e) => e.toString()).toList(),
    );
  }
  ProductVarientModel copyWith({
    int? buyingPrice,
    int? quantity,
    int? regularPrice,
    int? sellingPrice,
    Map<String, String?>? variantAttributes,
    List<String>? variantImageUrls,
  }) {
    return ProductVarientModel(
      buyingPrice: buyingPrice ?? this.buyingPrice,
      quantity: quantity ?? this.quantity,
      regularPrice: regularPrice ?? this.regularPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      variantAttributes: variantAttributes ?? this.variantAttributes,
      variantImageUrls: variantImageUrls ?? this.variantImageUrls,
    );
  }
}
