import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/features/cart/bloc/cart_bloc.dart';
import 'package:techmart/features/home_page/bloc/product_bloc.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';
import 'package:techmart/features/home_page/presentation/screens/add_to_cart.dart';
import 'package:techmart/features/home_page/utils/text_util.dart';

class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget({
    super.key,
    required this.effectiveVariant,
    required this.product,
    required this.state,
  });

  final ProductVarientModel effectiveVariant;
  final ProductModel product;
  final ProductLoadSuccess state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
      ),
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Price",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 4),
              AnimatedFlipCounter(
                value: state.selectedVariant.regularPrice,
                thousandSeparator: ",",
                prefix: '₹',
                textStyle: CustomTextStyles.cartPrice,

                duration: Duration(milliseconds: 500),
                curve: Curves.easeOut,
              ),
            ],
          ),

          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              bool isInCart = false;
              if (state is CartLoaded) {
                isInCart = state.isCartAdded(
                  effectiveVariant.varientId!,
                  product.productId,
                );
              }
              return AddtoCartBottomSheet(
                isInCart: isInCart,
                product: product,
                effectiveVariant: effectiveVariant,
              );
            },
          ),
        ],
      ),
    );
  }
}
