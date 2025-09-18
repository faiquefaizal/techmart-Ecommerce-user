import 'package:flutter/material.dart';
import 'package:techmart/features/orders/model/order_card_model.dart';
import 'package:techmart/features/rating/presentation/screens/rating_bottonsheet_widget.dart';

class RatingButten extends StatelessWidget {
  const RatingButten({super.key, required this.cartModel});

  final OrderCardModel cartModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ratingBottonSheet(context, cartModel.id);
      },
      child: Container(
        height: 35,
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          "Leave Review",

          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
