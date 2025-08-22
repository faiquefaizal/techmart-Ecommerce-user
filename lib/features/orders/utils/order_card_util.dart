import 'dart:developer';

import 'package:techmart/features/orders/model/order_card_model.dart';
import 'package:techmart/features/orders/model/order_model.dart';
import 'package:techmart/features/orders/service/order_service.dart';
import 'package:techmart/features/track_order/service/track_order_service.dart';

Future<List<OrderCardModel>> getOrderCard(List<OrderModel> orderList) async {
  final List<OrderCardModel> list = [];
  for (var order in orderList) {
    try {
      log(order.productId);
      log(order.varientId);

      final Map<String, dynamic> product = await OrderService()
          .fetchPRoductDetails(order.productId, order.varientId);
      final String productName = product["ProductName"]!;
      final String image = product["image"]!;
      final attibute = product["attributes"] as Map<String, dynamic>;
      list.add(
        OrderCardModel(
          productName: productName,
          status: order.status,
          id: order.orderId,
          total: order.total.toString(),
          image: image,
          attibute: attibute,
          ratingCount: order.ratingCount,
          ratingMessage: order.ratingText,
        ),
      );
    } catch (e) {
      log("funtion error${e.toString()}");
    }
  }
  return list;
}
