import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:logger/logger.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/core/widgets/label_align_price.dart';
import 'package:techmart/core/widgets/snakbar_widgert.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/cart/bloc/cart_bloc.dart';

import 'package:techmart/features/cart/presentation/screens/empty_cart_screen.dart';
import 'package:techmart/features/cart/presentation/screens/loaded_screen.dart';
import 'package:techmart/features/cart/presentation/widget/cart_product_shemmer.dart';
import 'package:techmart/features/cart/presentation/widget/cart_product_widget.dart';

import 'package:techmart/features/cart/utitl/cart_utitl.dart';
import 'package:techmart/features/check_out/cubit/select_payment_cubic.dart';
import 'package:techmart/features/check_out/cubit/selected_address_cubit.dart';
import 'package:techmart/features/check_out/presentation/screens/check_out_page.dart';
import 'package:techmart/features/coupen/cubit/coupen_cubit.dart';
import 'package:techmart/features/coupen/models/copen.model.dart';
import 'package:techmart/features/coupen/services/coupen_services.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartMinState) {
          log("minStatecalled");
          custemSnakbar(
            context: context,
            message: "Min 1 Quatity is requried",
            color: Colors.red,
          );
        } else if (state is CartMaxState) {
          custemSnakbar(
            context: context,
            message: "Max 5 Quantity allowed",
            color: Colors.orange,
          );
        } else if (state is CartErrorState) {
          custemSnakbar(
            context: context,
            message: state.error,
            color: Colors.red,
          );
          Logger().w(state.error);
        }
      },
      builder: (context, state) {
        if (state is LoadingCart) {
          return loadingShimmerCartBuilder();
        }
        if (state is CartIsEmpty) {
          return EmptyCartScreen();
        }

        if (state is CartLoaded) {
          final subtotal = getSubTotalFromCart(state.cartItems);
          final totalDiscount = getTotalDiscounts(state.cartItems);
          final shippingCharge = getShippingFee(int.parse(subtotal));
          final total = getTotalPrice(
            shopping: int.parse(subtotal),
            delivery: shippingCharge,
          );
          final sellerByMap = sellerTotal(state.cartItems);

          return CartLoadedScreen(
            subtotal: subtotal,
            totalDiscount: totalDiscount,
            shippingCharge: shippingCharge,
            total: total,
            sellerByMap: sellerByMap,
            state: state,
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
