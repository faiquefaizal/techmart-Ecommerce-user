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

class AddToCart extends StatelessWidget {
  const AddToCart({
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
    return CustemButton(
      Label: isInCart ? 'Go to Cart' : 'Add to Cart',

      onpressed: () {
        if (!isInCart) {
          final ProductCartModel cartModel = ProductCartModel(
            productName: product.productName,
            productId: product.productId,
            varientId: effectiveVariant.varientId!,
            quatity: 1,
            regularPrice: effectiveVariant.regularPrice.toString(),
            sellingPrice: effectiveVariant.sellingPrice.toString(),
            varientAttribute: effectiveVariant.variantAttributes,
            imageUrl: effectiveVariant.variantImageUrls!.first,
          );
          context.read<CartBloc>().add(AddToCartEvent(cartModel: cartModel));
        }
      },
    );
  }
}
