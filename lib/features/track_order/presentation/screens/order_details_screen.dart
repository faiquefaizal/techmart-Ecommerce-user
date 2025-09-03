import 'package:flutter/material.dart';
import 'package:techmart/core/utils/price_formater.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';

import 'package:techmart/features/home_page/utils/text_util.dart';
import 'package:techmart/features/invoice/model/invoice_model.dart';
import 'package:techmart/features/invoice/service/invoice_service.dart';
import 'package:techmart/features/orders/model/order_model.dart';
import 'package:techmart/features/return_request/presentation/screen/return_screen.dart';
import 'package:techmart/features/track_order/presentation/widgets/invoice_button_widget.dart';
import 'package:techmart/features/track_order/presentation/widgets/order_card.dart';
import 'package:techmart/features/track_order/presentation/widgets/price_row.dart';
import 'package:techmart/features/track_order/presentation/widgets/product_card_widget.dart';
import 'package:techmart/features/track_order/presentation/widgets/return_button_widget.dart';
import 'package:techmart/features/track_order/presentation/widgets/status_widget.dart';
import 'package:techmart/features/track_order/utils/helper_funtions.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel orderModel;
  final Map<String, dynamic> productDetails;
  const OrderDetailsScreen({
    super.key,
    required this.orderModel,
    required this.productDetails,
  });
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: custemAppbar(heading: "OrderDetails", context: context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: OrderCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: size.width * 0.55),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order ID: ${orderModel.orderId}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Order Date: ${orderModel.createTime.toFancyFormat()}",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  StatusWisget(status: orderModel.status),
                ],
              ),
              VerticalSpaceWisget(20),
              Divider(),
              VerticalSpaceWisget(20),
              ProductCardWidget(
                image: productDetails["Image"]!,
                orderName: productDetails["Name"]!,
                orderProductAttributes: (productDetails["varientAttributes"]!
                        as Map<String, dynamic>)
                    .entries
                    .map((element) => "${element.key} ${element.value}")
                    .join("•"),
                count: orderModel.quantity,
                price: orderModel.total.toString(),
              ),

              ReturnButtonWidget(
                date: orderModel.createTime,
                onpressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (context) => ReturnScreen(
                            orderId: orderModel.orderId,
                            image: productDetails["Image"]!,
                            productName: productDetails["Name"]!,
                            productinfo: (productDetails["varientAttributes"]!
                                    as Map<String, dynamic>)
                                .entries
                                .map(
                                  (element) =>
                                      "${element.key} ${element.value}",
                                )
                                .join(","),
                            count: orderModel.quantity,
                            price: orderModel.total.toString(),
                          ),
                    ),
                  );
                },
                status: orderModel.status,
              ),
              Divider(height: 30),

              Text(
                "Payment Details",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 10),
              summaryRow("PaymentMethod", label: orderModel.paymentMode),
              summaryRow("Subtotal", value: 24),
              summaryRow("Shipping", value: 22),
              summaryRow("Tax", value: getTaxInfo((orderModel.total))),
              Divider(),
              summaryRow("Total", value: 255, isBold: true),

              Divider(),
              VerticalSpaceWisget(10),
              InvoiceButtonWidget(
                onpressed: () async {
                  InvoiceModel invoice = InvoiceModel(
                    productDetails: productDetails,
                    orderModel: orderModel,
                  );
                  final data = await InvoiceService.generateInvoice(invoice);
                  await InvoiceService.saveInvoice(
                    DateTime.now().toString(),
                    data,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
