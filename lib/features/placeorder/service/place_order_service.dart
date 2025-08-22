// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:techmart/core/utils/genrete_firbase_id.dart';
// import 'package:techmart/features/address/models/address_model.dart';
// import 'package:techmart/features/authentication/service/Auth_service.dart';
// import 'package:techmart/features/cart/bloc/cart_bloc.dart';

// import 'package:techmart/features/cart/model/product_cart_model.dart';
// import 'package:techmart/features/coupen/models/copen.model.dart';
// import 'package:techmart/features/orders/model/order_model.dart';

// const pendingStatus = "Pending";

// class PlaceOrderService {
//   final CollectionReference _orderRef = FirebaseFirestore.instance.collection(
//     "Orders",
//   );
//   final CollectionReference _productRef = FirebaseFirestore.instance.collection(
//     "Products",
//   );
//   final CollectionReference _userRef = FirebaseFirestore.instance.collection(
//     "Users",
//   );

//   // void makeOrder(
//   //   BuildContext context,
//   //   AddressModel address,
//   //   int total,
//   //   String paymentId,
//   //   String deliverycharge,
//   // ) async {
//   // final delveryCharge = total > 1000 ? 0 : 100;
//   // String? userId = AuthService().getUserId();
//   // List<ProductCartModel> cartList =
//   //     (context.read<CartBloc>().state as CartLoaded).cartItems;
//   // DateTime time = DateTime.now();
//   // for (ProductCartModel item in cartList) {
//   //   String orderId = genertateFirebase();
//   //   DocumentReference orderRef = _orderRef.doc(orderId);
//   //   final sellerId = item.sellerId;

//   //   final productTotal = item.quatity * int.parse(item.regularPrice);
//   //   OrderModel orderModel = OrderModel(
//   //     orderId: orderId,
//   //     address: address,
//   //     userId: userId!,
//   //     sellerId: sellerId!,
//   //     createTime: time,
//   //     quantity: item.quatity,
//   //     total: (productTotal).toDouble(),
//   //     paymentId: paymentId,
//   //     status: pendingStatus,
//   //     returnReason: null,
//   //     deliveryCharge: delveryCharge.toDouble(),
//   //   );
//   //   firabasebatch.set(orderRef, orderModel.toJson());
//   // }
//   // await firabasebatch.commit();

//   // for (var cart in cartList) {
//   //   String _varientId = cart.varientId;
//   //   String _productId = cart.productId;
//   //   int count = cart.quatity;
//   //   DocumentSnapshot productDoc =
//   //       await _productRef
//   //           .doc(_productId)
//   //           .collection("varients")
//   //           .doc(_varientId)
//   //           .get();
//   //   final productQuatity =
//   //       (productDoc.data() as Map<String, dynamic>)["quantity"];

//   //   await _productRef
//   //       .doc(_productId)
//   //       .collection("varients")
//   //       .doc(_varientId)
//   //       .update({"quantity": productQuatity - count});
//   // }

//   Future<void> placeOrderWithStripe({
//     required List<ProductCartModel> cartList,
//     required AddressModel address,
//     required int total,
//     required String paymentId,
//     required String deliverycharge,
//     String? coupenCode,
//   }) async {
//     try {
//       final delveryCharge = total > 1000 ? 0 : 100;
//       String? userId = AuthService().getUserId();

//       DateTime time = DateTime.now();

//       FirebaseFirestore.instance.runTransaction((transaction) async {
//         for (var cart in cartList) {
//           final varientRef = _productRef
//               .doc(cart.productId)
//               .collection("varients")
//               .doc(cart.varientId);

//           var varientDoc = await transaction.get(varientRef);
//           if (!varientDoc.exists) {
//             throw Exception("This Product Does not Exist");
//           }
//           int count = varientDoc.get("quantity");
//           if (count < cart.quatity) {
//             throw Exception(
//               "Not enough stock for product ${cart.productId}. Only $count left.",
//             );
//           }

//           final updatedQuatity = count - cart.quatity;
//           transaction.update(varientRef, {"quantity": updatedQuatity});
//           final sellerId = cart.sellerId;
//           final productTotal =
//               double.parse(cart.regularPrice) * (cart.quatity).toDouble();
//           final orderId = genertateFirebase();
//           final OrderModel orderModel = OrderModel(
//             productId: cart.productId,
//             varientId: cart.varientId,
//             orderId: orderId,
//             address: address,
//             userId: userId!,
//             sellerId: sellerId!,
//             createTime: time,
//             quantity: cart.quatity,
//             total: productTotal,
//             paymentId: paymentId,
//             status: pendingStatus,
//             returnReason: null,
//             deliveryCharge: delveryCharge.toDouble(),
//           );
//           transaction.set(
//             _orderRef.doc(orderModel.orderId),
//             orderModel.toJson(),
//           );

//           if (coupenCode != null) {
//             UsedCoupenModel usedCOupen = UsedCoupenModel(
//               id: genertateFirebase(),
//               name: coupenCode,
//             );
//             final CollectionReference coupenRef = _userRef
//                 .doc(userId!)
//                 .collection("UsedCollection");
//             transaction.set(coupenRef.doc(usedCOupen.id), usedCOupen.toMap());
//           }
//           final cartRef = _userRef
//               .doc(userId)
//               .collection("Cart")
//               .doc(cart.cartId);
//           transaction.delete(cartRef);

//           log("Order Placed Succesflly");
//         }
//       });
//     } catch (e) {
//       log(e.toString());
//       rethrow;
//     }
//   }

//   Future<void> placeOrderCod({
//     required List<ProductCartModel> cartList,
//     required AddressModel address,
//     required int total,

//     required String deliverycharge,
//     String? coupenCode,
//   }) async {
//     try {
//       final delveryCharge = total > 1000 ? 0 : 100;
//       String? userId = AuthService().getUserId();

//       DateTime time = DateTime.now();

//       FirebaseFirestore.instance.runTransaction((transaction) async {
//         for (var cart in cartList) {
//           final varientRef = _productRef
//               .doc(cart.productId)
//               .collection("varients")
//               .doc(cart.varientId);

//           var varientDoc = await transaction.get(varientRef);
//           if (!varientDoc.exists) {
//             throw Exception("This Product Does not Exist");
//           }

//           num count = varientDoc.get("quantity");
//           log(count.toString());
//           if (count < cart.quatity) {
//             throw Exception(
//               "Not enough stock for product ${cart.productId}. Only $count left.",
//             );
//           }

//           final updatedQuatity = count - cart.quatity;
//           transaction.update(varientRef, {"quantity": updatedQuatity});
//           final sellerId = cart.sellerId;
//           final productTotal =
//               double.parse(cart.regularPrice) * (cart.quatity).toDouble();
//           final orderId = genertateFirebase();
//           final OrderModel orderModel = OrderModel(
//             productId: cart.productId,
//             varientId: cart.varientId,
//             orderId: orderId,
//             address: address,
//             userId: userId!,
//             sellerId: sellerId!,
//             createTime: time,
//             quantity: cart.quatity,
//             total: productTotal,
//             paymentId: null,
//             status: pendingStatus,
//             returnReason: null,
//             deliveryCharge: delveryCharge.toDouble(),
//           );
//           transaction.set(
//             _orderRef.doc(orderModel.orderId),
//             orderModel.toJson(),
//           );

//           if (coupenCode != null) {
//             UsedCoupenModel usedCOupen = UsedCoupenModel(
//               id: genertateFirebase(),
//               name: coupenCode,
//             );
//             final CollectionReference coupenRef = _userRef
//                 .doc(userId)
//                 .collection("UsedCollection");
//             transaction.set(coupenRef.doc(usedCOupen.id), usedCOupen.toMap());
//           }
//           final cartRef = _userRef
//               .doc(userId)
//               .collection("Cart")
//               .doc(cart.cartId);
//           transaction.delete(cartRef);
//         }
//         log("Order Placed Succesflly");
//       });
//     } catch (e) {
//       log(e.toString());
//       rethrow;
//     }
//   }
// }

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:techmart/core/utils/genrete_firbase_id.dart';
import 'package:techmart/features/address/models/address_model.dart';
import 'package:techmart/features/authentication/service/Auth_service.dart';
import 'package:techmart/features/cart/bloc/cart_bloc.dart';
import 'package:techmart/features/cart/model/product_cart_model.dart';
import 'package:techmart/features/coupen/models/copen.model.dart';
import 'package:techmart/features/orders/model/order_model.dart';

const pendingStatus = "Pending";

class PlaceOrderService {
  final CollectionReference _orderRef = FirebaseFirestore.instance.collection(
    "Orders",
  );
  final CollectionReference _productRef = FirebaseFirestore.instance.collection(
    "Products",
  );
  final CollectionReference _userRef = FirebaseFirestore.instance.collection(
    "Users",
  );

  // void makeOrder(
  //   BuildContext context,
  //   AddressModel address,
  //   int total,
  //   String paymentId,
  //   String deliverycharge,
  // ) async {
  // final delveryCharge = total > 1000 ? 0 : 100;
  // String? userId = AuthService().getUserId();
  // List<ProductCartModel> cartList =
  //     (context.read<CartBloc>().state as CartLoaded).cartItems;
  // DateTime time = DateTime.now();
  // for (ProductCartModel item in cartList) {
  //   String orderId = genertateFirebase();
  //   DocumentReference orderRef = _orderRef.doc(orderId);
  //   final sellerId = item.sellerId;

  //   final productTotal = item.quatity * int.parse(item.regularPrice);
  //   OrderModel orderModel = OrderModel(
  //     orderId: orderId,
  //     address: address,
  //     userId: userId!,
  //     sellerId: sellerId!,
  //     createTime: time,
  //     quantity: item.quatity,
  //     total: (productTotal).toDouble(),
  //     paymentId: paymentId,
  //     status: pendingStatus,
  //     returnReason: null,
  //     deliveryCharge: delveryCharge.toDouble(),
  //   );
  //   firabasebatch.set(orderRef, orderModel.toJson());
  // }
  // await firabasebatch.commit();

  // for (var cart in cartList) {
  //   String _varientId = cart.varientId;
  //   String _productId = cart.productId;
  //   int count = cart.quatity;
  //   DocumentSnapshot productDoc =
  //       await _productRef
  //           .doc(_productId)
  //           .collection("varients")
  //           .doc(_varientId)
  //           .get();
  //   final productQuatity =
  //       (productDoc.data() as Map<String, dynamic>)["quantity"];

  //   await _productRef
  //       .doc(_productId)
  //       .collection("varients")
  //       .doc(_varientId)
  //       .update({"quantity": productQuatity - count});
  // }

  Future<void> placeOrderWithStripe({
    required List<ProductCartModel> cartList,
    required AddressModel address,
    required int total,
    required String paymentId,
    required String deliverycharge,
    String? coupenCode,
  }) async {
    try {
      Logger().d(paymentId);

      final delveryCharge = total > 1000 ? 0 : 100;
      String? userId = AuthService().getUserId();
      Logger().d(userId);
      if (userId == null) {
        throw Exception("User id null");
      }
      DateTime time = DateTime.now();

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        Map<String, DocumentSnapshot> variantDocs = {};
        for (var cart in cartList) {
          final varientRef = _productRef
              .doc(cart.productId)
              .collection("varients")
              .doc(cart.varientId);
          variantDocs[cart.varientId] = await transaction.get(varientRef);
        }

        for (var cart in cartList) {
          final varientDoc = variantDocs[cart.varientId]!;
          if (!varientDoc.exists) {
            throw Exception("This Product Does not Exist");
          }
          int count = varientDoc.get("quantity");
          if (count < cart.quatity) {
            throw Exception(
              "Not enough stock for product ${cart.productId}. Only $count left.",
            );
          }

          final updatedQuatity = count - cart.quatity;
          transaction.update(varientDoc.reference, {
            "quantity": updatedQuatity,
          });
          final sellerId = cart.sellerId;
          final productTotal =
              double.parse(cart.regularPrice) * (cart.quatity).toDouble();
          final orderId = genertateFirebase();
          final OrderModel orderModel = OrderModel(
            productId: cart.productId,
            varientId: cart.varientId,
            orderId: orderId,
            address: address,
            userId: userId!,
            sellerId: sellerId!,
            createTime: time,
            quantity: cart.quatity,
            total: productTotal,
            paymentId: paymentId,
            status: pendingStatus,
            returnReason: null,
            deliveryCharge: delveryCharge.toDouble(),
          );
          Logger().d(orderModel.toString());
          transaction.set(
            _orderRef.doc(orderModel.orderId),
            orderModel.toJson(),
          );

          if (coupenCode != null) {
            UsedCoupenModel usedCOupen = UsedCoupenModel(
              id: genertateFirebase(),
              name: coupenCode,
            );
            final CollectionReference coupenRef = _userRef
                .doc(userId!)
                .collection("UsedCollection");
            transaction.set(coupenRef.doc(usedCOupen.id), usedCOupen.toMap());
          }
          final cartRef = _userRef
              .doc(userId)
              .collection("Cart")
              .doc(cart.cartId);
          transaction.delete(cartRef);

          log("Order Placed Succesflly");
        }
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> placeOrderCod({
    required List<ProductCartModel> cartList,
    required AddressModel address,
    required int total,
    required String deliverycharge,
    String? coupenCode,
  }) async {
    try {
      final delveryCharge = total > 1000 ? 0 : 100;
      String? userId = AuthService().getUserId();

      DateTime time = DateTime.now();

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        Map<String, DocumentSnapshot> variantDocs = {};
        for (var cart in cartList) {
          final varientRef = _productRef
              .doc(cart.productId)
              .collection("varients")
              .doc(cart.varientId);
          variantDocs[cart.varientId] = await transaction.get(varientRef);
        }

        // Step 2: Perform updates and writes
        for (var cart in cartList) {
          final varientDoc = variantDocs[cart.varientId]!;
          if (!varientDoc.exists) {
            throw Exception("This Product Does not Exist");
          }

          num count = varientDoc.get("quantity");
          log(count.toString());
          if (count < cart.quatity) {
            throw Exception(
              "Not enough stock for product ${cart.productId}. Only $count left.",
            );
          }

          final updatedQuatity = count - cart.quatity;
          transaction.update(varientDoc.reference, {
            "quantity": updatedQuatity,
          });
          final sellerId = cart.sellerId;
          final productTotal =
              double.parse(cart.regularPrice) * (cart.quatity).toDouble();
          final orderId = genertateFirebase();
          final OrderModel orderModel = OrderModel(
            productId: cart.productId,
            varientId: cart.varientId,
            orderId: orderId,
            address: address,
            userId: userId!,
            sellerId: sellerId!,
            createTime: time,
            quantity: cart.quatity,
            total: productTotal,
            paymentId: null,
            status: pendingStatus,
            returnReason: null,
            deliveryCharge: delveryCharge.toDouble(),
          );
          transaction.set(
            _orderRef.doc(orderModel.orderId),
            orderModel.toJson(),
          );

          if (coupenCode != null) {
            UsedCoupenModel usedCOupen = UsedCoupenModel(
              id: genertateFirebase(),
              name: coupenCode,
            );
            final CollectionReference coupenRef = _userRef
                .doc(userId)
                .collection("UsedCollection");
            transaction.set(coupenRef.doc(usedCOupen.id), usedCOupen.toMap());
          }
          final cartRef = _userRef
              .doc(userId)
              .collection("Cart")
              .doc(cart.cartId);
          transaction.delete(cartRef);
        }
        log("Order Placed Succesflly");
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
