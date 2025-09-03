import 'package:flutter/material.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/core/widgets/form_field.dart';
import 'package:techmart/core/widgets/snakbar_widgert.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/return_request/presentation/widgets/retun_card_widget.dart';
import 'package:techmart/features/return_request/service/return_service.dart';
import 'package:techmart/features/track_order/presentation/widgets/product_card_widget.dart';

class ReturnScreen extends StatelessWidget {
  final String orderId;
  final String image;
  final String productName;
  final String productinfo;
  final String price;
  final int count;
  const ReturnScreen({
    super.key,
    required this.orderId,
    required this.image,
    required this.productName,
    required this.productinfo,
    required this.count,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController returnReasonController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: custemAppbar(heading: "Return", context: context),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selected Item",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              ProductCardWidget(
                image: image,
                orderName: productName,
                orderProductAttributes: productinfo,
                count: count,
                price: price,
              ),
              const SizedBox(height: 24),
              const Text(
                "Reason for Return",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const VerticalSpaceWisget(8),

              ReturnReasonWisget(
                returnReasonController: returnReasonController,
              ),
              const VerticalSpaceWisget(13),
              CustemButton(
                textSize: 22,
                label: "Request Return",
                onpressed: () async {
                  if (returnReasonController.text.trim().isEmpty) {
                    return custemSnakbar(
                      context: context,
                      message: "Reason Cant Be empty",
                      color: Colors.red,
                    );
                  }
                  await ReturnService().requestReturn(
                    orderId,
                    returnReasonController.text.trim(),
                  );

                  if (context.mounted) {
                    custemSnakbar(
                      context: context,
                      message: "Return Requested Successfully",
                      color: Colors.green,
                    );
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
