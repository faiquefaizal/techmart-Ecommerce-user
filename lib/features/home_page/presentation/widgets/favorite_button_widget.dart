import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';
import 'package:techmart/features/wishlist_page/cubit/wishlist_cubit.dart';

class favrite_widget extends StatelessWidget {
  const favrite_widget({
    super.key,
    required this.isWishList,
    required this.product,
    required this.variant,
  });

  final bool isWishList;
  final ProductModel product;
  final ProductVarientModel variant;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            (isWishList)
                ? const Color.fromARGB(255, 245, 227, 230)
                : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      height: 40,
      width: 40,
      child: IconButton(
        icon:
            (isWishList)
                ? Icon(Icons.favorite, color: Colors.red)
                : Icon(Icons.favorite_border, color: Colors.black),
        onPressed: () {
          context.read<WishlistCubit>().toggleWishList(
            product.productId,
            variant.varientId!,
          );
        },
      ),
    );
  }
}
