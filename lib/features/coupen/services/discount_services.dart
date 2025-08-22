import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:techmart/features/coupen/models/admin_coupen_model.dart';
import 'package:techmart/features/coupen/models/copen.model.dart';

class DiscountService {
  static double applySellerCoupon({
    required SellerCoupon coupon,
    required double sellerTotal,
  }) {
    final now = DateTime.now();
    if (!coupon.isActive ||
        now.isBefore(coupon.startTime) ||
        now.isAfter(coupon.endTime)) {
      throw Exception("Seller coupon expired or inactive");
    }
    if (sellerTotal < coupon.minimumPrice) {
      throw Exception("Minimum order value not met for seller coupon");
    }
    return (coupon.discountPercentage / 100.0) * sellerTotal;
  }

  static double applyAdminCoupon({
    required AdminCoupon coupon,
    required double cartTotal,
  }) {
    final now = DateTime.now();
    if (!coupon.isLive ||
        now.isBefore(coupon.startTime) ||
        now.isAfter(coupon.endTime)) {
      log(now.isBefore(coupon.startTime).toString());
      log(now.isAfter(coupon.startTime).toString());
      log(coupon.startTime.toString());
      log(coupon.endTime.toString());
      throw Exception("Admin coupon expired or inactive");
    }
    if (cartTotal < coupon.minimumPrice) {
      throw Exception("Minimum cart value not met for admin coupon");
    }
    return coupon.flatDiscount * 1.0;
  }
}
