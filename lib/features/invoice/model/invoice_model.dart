import 'package:techmart/features/orders/model/order_model.dart';
import 'package:techmart/features/track_order/utils/helper_funtions.dart';

class InvoiceModel {
  final OrderModel orderModel;
  final String productDiscription;

  // String businnessName;
  final double taxAmount;
  InvoiceModel({
    required Map<String, dynamic> productDetails,
    required this.orderModel,

    // required this.businnessName,
  }) : taxAmount = getTaxInfo(orderModel.total),
       productDiscription =
           "${productDetails["Name"]! as String}${(productDetails["varientAttributes"]! as Map<String, dynamic>).entries.map((element) => "${element.key} ${element.value}").join(",")}";
}
