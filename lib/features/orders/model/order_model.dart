import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:techmart/features/address/models/address_model.dart';

class OrderModel extends Equatable {
  final String orderId;
  final String productId;
  final String varientId;
  final String userId;
  final String sellerId;
  final DateTime createTime;
  final int quantity;
  final double total;
  final AddressModel address;
  final String? paymentId;
  final String status;
  final String? returnReason;
  final double? deliveryCharge;
  final String? couponCode;
  final String paymentMode;
  final DateTime? updateTime;
  final String? ratingText;
  final num ratingCount;
  OrderModel({
    required this.productId,
    required this.varientId,
    required this.orderId,
    required this.userId,
    required this.sellerId,
    required this.createTime,
    required this.quantity,
    required this.total,
    required this.address,
    this.paymentId,
    required this.status,
    this.returnReason,
    this.updateTime,
    this.deliveryCharge,
    this.ratingCount = 0,
    this.ratingText,
    this.couponCode,
  }) : paymentMode = (paymentId != null) ? "Online" : "COD";

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      ratingCount: json["rating"] ?? 0,
      ratingText: json["ratingText"],
      orderId: json['orderId'] ?? '',
      userId: json['userId'] ?? '',
      sellerId: json['sellerId'] ?? '',
      varientId: json["varientId"] ?? "",
      productId: json["productId"] ?? "",
      createTime: (json['createTime'] as Timestamp).toDate(),
      quantity: json['quantity'] ?? 0,
      total: (json['total'] as num).toDouble(),
      address: AddressModel.fromMap(json['address']),
      paymentId: json['paymentId'] ?? '',
      status: json['status'] ?? '',
      returnReason: json['returnReason'],
      updateTime: ((json["updatedTime"] as Timestamp?)?.toDate()),
      deliveryCharge: (json['deliveryCharge'] as num?)?.toDouble(),

      couponCode: json['couponCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ratingText": ratingText,
      "rating": ratingCount,
      "productId": productId,
      "varientId": varientId,
      'orderId': orderId,
      'userId': userId,
      'sellerId': sellerId,
      'createTime': createTime,
      'quantity': quantity,
      'total': total,
      'address': address.toMap(),
      'paymentId': paymentId,
      'status': status,
      'returnReason': returnReason,
      "updatedTime": updateTime,
      'deliveryCharge': deliveryCharge,

      'couponCode': couponCode,
    };
  }

  @override
  List<Object> get props => [status, ratingCount];
}
