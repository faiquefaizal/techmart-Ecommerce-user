import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:techmart/features/authentication/service/Auth_service.dart';
import 'package:techmart/features/coupen/models/admin_coupen_model.dart';
import 'package:techmart/features/coupen/models/copen.model.dart';
import 'package:techmart/features/coupen/services/discount_services.dart';

class CoupenServices {
  final _adminCoupen = FirebaseFirestore.instance.collection("AdminCoupouns");
  final _sellerCoupen = FirebaseFirestore.instance.collection("seller_coupons");

  CollectionReference get _usedCoupen {
    final userId = AuthService().getUserId() ?? "not Logged In";
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .collection("UsedCollection");
  }

  // void addUsedCoupen(String coupenId,) {
  //   _usedCoupen.doc(coupen.id).set({
  //     "coupencode": coupen.couponName,
  //     "usedTime": DateTime.now(),
  //   });
  // }

  Future<bool> checkIfUsed(String coupen) async {
    final coupens =
        await _usedCoupen
            .where(coupen.toLowerCase(), isEqualTo: "couponName")
            .get();
    return coupens.docs.isNotEmpty;
  }

  Future<double> checkAndApplyCoupon({
    required String couponCode,
    required double cartTotal,
    required Map<String, double> sellerTotals,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;
      if (couponCode.isEmpty) {
        throw Exception("Code is Empty");
      }
      final adminQuery =
          await firestore
              .collection("AdminCoupouns")
              .where("name", isEqualTo: couponCode)
              .get();

      if (adminQuery.docs.isNotEmpty) {
        log("adminQuery");
        final data = adminQuery.docs.first.data();

        final adminCoupon = AdminCoupon.fromMap(data);

        if (await checkIfUsed(adminCoupon.id)) {
          log("used");
          throw Exception("Coupon already used");
        }

        final discount = DiscountService.applyAdminCoupon(
          coupon: adminCoupon,
          cartTotal: cartTotal,
        );
        log(discount.toString());

        return discount;
      }

      final sellerQuery =
          await firestore
              .collection("seller_coupons")
              .where("couponName", isEqualTo: couponCode)
              .get();

      if (sellerQuery.docs.isNotEmpty) {
        log("SEllerQuery");
        final data = sellerQuery.docs.first.data();
        log("null checka before seller coupen fetching");
        log(data.toString());
        final sellerCoupon = SellerCoupon.fromMap(data);

        if (await checkIfUsed(sellerCoupon.id)) {
          throw Exception("Coupon already used");
        }
        log("null checka before");
        final sellerId = sellerCoupon.sellerId;

        log(sellerId);
        log("null check");
        if (!sellerTotals.containsKey(sellerId)) {
          throw Exception("No items from this seller in cart");
        }

        final discount = DiscountService.applySellerCoupon(
          coupon: sellerCoupon,
          sellerTotal: sellerTotals[sellerId]!,
        );

        //  await markCouponAsUsed(userId, sellerCoupon.id, sellerCoupon.couponName);
        return discount;
      }
      throw Exception("Invalid coupon code");
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
