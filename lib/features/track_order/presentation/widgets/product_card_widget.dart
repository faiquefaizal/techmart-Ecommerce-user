import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techmart/core/utils/price_formater.dart';
import 'package:techmart/features/home_page/utils/text_util.dart';

class ProductCardWidget extends StatelessWidget {
  final String image;
  final String orderName;
  final String orderProductAttributes;
  final int count;
  final String price;

  const ProductCardWidget({
    super.key,
    required this.image,
    required this.orderName,
    required this.orderProductAttributes,
    required this.count,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            image,
            width: 70,
            height: 70,

            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(orderName, style: Theme.of(context).textTheme.labelSmall),
              SizedBox(height: 4),
              Text(orderProductAttributes),
              Text("Qty: $count"),
              SizedBox(height: 4),
              Text(
                formatIndianPrice(num.parse(price)),
                style: CustomTextStyles.cartCardPrice,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
