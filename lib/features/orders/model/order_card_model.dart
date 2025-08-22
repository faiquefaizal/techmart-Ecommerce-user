import 'package:cloud_firestore/cloud_firestore.dart';

class OrderCardModel {
  String id;
  String productName;
  String total;
  String status;
  String image;
  Map<String, dynamic> attibute;
  double ratingCount;

  String? ratingMessage;

  OrderCardModel({
    required this.productName,
    required this.status,
    required this.id,
    required this.total,
    required this.image,
    required this.attibute,
    required this.ratingCount,
    this.ratingMessage,
  });
  @override
  String toString() {
    return "OrderCardModel(productName: $productName, status: $status, id: $id, total: $total, image: $image, attibute: $attibute,count $ratingCount,message:$ratingMessage)";
  }
}
