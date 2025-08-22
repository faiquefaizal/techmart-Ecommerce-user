import 'package:cloud_firestore/cloud_firestore.dart';

class AdminCoupon {
  final String id;
  final String name;
  final int flatDiscount;
  final int minimumPrice;
  final bool isLive;
  final DateTime startTime;
  final DateTime endTime;

  AdminCoupon({
    required this.id,
    required this.name,
    required this.flatDiscount,
    required this.minimumPrice,
    required this.isLive,
    required this.startTime,
    required this.endTime,
  });

  factory AdminCoupon.fromMap(Map<String, dynamic> map) {
    return AdminCoupon(
      id: map['id'],
      name: map['name'],
      flatDiscount: map['dicountPrice'],
      minimumPrice: map['minPrice'],
      isLive: map['isLive'],
      startTime: (map['startTime'] as Timestamp).toDate(),
      endTime: (map['endTime'] as Timestamp).toDate(),
    );
  }
}
