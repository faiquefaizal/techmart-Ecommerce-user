import 'package:flutter/material.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';

class WishListButtonIcon extends StatelessWidget {
  const WishListButtonIcon({
    super.key,
    required this.isWishList,
    required this.product,
    required this.singleVariant,
    required this.ontap,
  });
  final VoidCallback ontap;
  final bool isWishList;
  final ProductModel product;
  final ProductVarientModel singleVariant;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon:
          (isWishList)
              ? Icon(Icons.favorite, color: Colors.black)
              : Icon(Icons.favorite_border, color: Colors.black),
      onPressed: ontap,
    );
  }
}
