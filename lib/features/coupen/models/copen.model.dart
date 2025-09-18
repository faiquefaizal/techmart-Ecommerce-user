import 'package:cloud_firestore/cloud_firestore.dart';

class SellerCoupon {
  final String id;
  final String couponName;
  final int discountPercentage;
  final DateTime startTime;
  final DateTime endTime;
  final bool isActive;
  final int minimumPrice;
  final String sellerId;

  SellerCoupon({
    required this.id,
    required this.couponName,
    required this.discountPercentage,
    required this.startTime,
    required this.endTime,
    required this.isActive,
    required this.minimumPrice,
    required this.sellerId,
  });

  factory SellerCoupon.fromMap(Map<String, dynamic> map) {
    return SellerCoupon(
      id: map['id'],
      couponName: map['couponName'],
      discountPercentage: map['discountPercentage'],
      startTime: (map['startTime'] as Timestamp).toDate(),
      endTime: (map['endTime'] as Timestamp).toDate(),
      isActive: map['isActive'],
      minimumPrice: map['minimumPrice'],
      sellerId: map['sellerid'],
    );
  }
}

class UsedCoupenModel {
  String id;
  String name;
  DateTime usedtime;
  UsedCoupenModel({required this.id, required this.name})
    : usedtime = DateTime.now();

  Map<String, dynamic> toMap() {
    return {"Id": id, "couponName": name, "usedTime": usedtime};
  }
}
