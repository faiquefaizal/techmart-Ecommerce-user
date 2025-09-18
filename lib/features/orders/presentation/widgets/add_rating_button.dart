import 'package:flutter/material.dart';
import 'package:techmart/features/orders/model/order_card_model.dart';

class AddRatingButton extends StatelessWidget {
  const AddRatingButton({super.key, required this.cartModel});

  final OrderCardModel cartModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 80,
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(5),
      ),
      child: FittedBox(
        child: Row(
          children: [
            Icon(Icons.star, color: Color.fromRGBO(255, 153, 0, 100)),
            Text("${cartModel.ratingCount}/5"),
          ],
        ),
      ),
    );
  }
}
