import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/utils/color_utils.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/features/cart/bloc/cart_bloc.dart';
import 'package:techmart/features/cart/model/product_cart_model.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';

class add_to_cart_botton extends StatelessWidget {
  const add_to_cart_botton({
    super.key,
    required this.isInCart,
    required this.product,
    required this.effectiveVariant,
  });

  final bool isInCart;
  final ProductModel product;
  final ProductVarientModel effectiveVariant;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: NeoPopButton(
        color: Colors.black,
        bottomShadowColor: Color.fromARGB(255, 70, 126, 72),
        rightShadowColor: Color.fromARGB(255, 70, 126, 72),

        onTapUp: () {},
        border: Border.all(color: Color.fromARGB(255, 70, 126, 72), width: 1),
        child: Center(
          child: Text(
            isInCart ? 'Go to Cart' : 'Add to Cart',
            style: GoogleFonts.schibstedGrotesk(
              color: Colors.white,

              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // onTapUp: () {
        //   if (!isInCart) {
        //     final ProductCartModel cartModel = ProductCartModel(
        //       productName: product.productName,
        //       productId: product.productId,
        //       varientId: effectiveVariant.varientId!,
        //       quatity: 1,
        //       regularPrice: effectiveVariant.regularPrice.toString(),
        //       sellingPrice: effectiveVariant.sellingPrice.toString(),
        //       varientAttribute: effectiveVariant.variantAttributes,
        //       imageUrl: effectiveVariant.variantImageUrls!.first,
        //     );
        //     context.read<CartBloc>().add(AddToCartEvent(cartModel: cartModel));
        //   }
        // },
      ),
    );
  }
}
