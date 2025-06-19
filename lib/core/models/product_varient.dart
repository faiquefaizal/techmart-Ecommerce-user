// techmart_seller/features/products/models/product_varient_model.dart
// (This model would ideally be in a shared 'models' folder accessible by both apps)

class ProductVarientModel {
  String variantName;
  String variantValue;
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
    required this.variantName,
    required this.variantValue,
    this.variantImageUrls,
  });

  Map<String, dynamic> toMap() {
    return {
      "variantName": variantName,
      "variantValue": variantValue,
      "quantity": quantity,
      "regularPrice": regularPrice,
      "sellingPrice": sellingPrice,
      "buyingPrice": buyingPrice,
      "variantImageUrls": variantImageUrls,
    };
  }

  factory ProductVarientModel.fromMap(Map<String, dynamic> map) {
    return ProductVarientModel(
      buyingPrice: map["buyingPrice"] ?? 0,
      quantity: map["quantity"] ?? 0,
      regularPrice: map["regularPrice"] ?? 0,
      sellingPrice: map["sellingPrice"] ?? 0,
      variantName: map["variantName"] ?? "",
      variantValue: map["variantValue"] ?? "",
      variantImageUrls:
          (map["variantImageUrls"] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}
