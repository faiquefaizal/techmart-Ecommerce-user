import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/core/widgets/snakbar_widgert.dart';
import 'package:techmart/features/cart/bloc/cart_bloc.dart';

import 'package:techmart/features/cart/presentation/screens/empty_cart_screen.dart';
import 'package:techmart/features/cart/presentation/widget/cart_product_widget.dart';
import 'package:techmart/features/cart/utitl/cart_utitl.dart';

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
        } else if (state is CartMaxState || state is CartErrorState) {
          custemSnakbar(
            context: context,
            message: "Max 5 Quantity allowed",
            color: Colors.orange,
          );
          custemSnakbar(
            context: context,
            message: (state as CartErrorState).error,
            color: Colors.red,
          );
          Logger().w(state.error);
        }
      },
      builder: (context, state) {
        if (state is LoadingCart) {
          Logger().i("loading stati shwon in the screen ");
        }
        if (state is CartIsEmpty) {
          return EmptyCartScreen();
        }

        if (state is CartLoaded) {
          final subtotal = getSubTotalFromCart(state.cartItems);
          final totalDiscount = getTotalDiscounts(state.cartItems);

          return Scaffold(
            appBar: custemAppbar(heading: "My Cart", context: context),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = state.cartItems[index];
                        log("buidler is called $cartItem");
                        return CustemProductCard(cartModel: cartItem);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Subtotal",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                subtotal,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Discount",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                totalDiscount,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          Logger().w("no state");
          return Text("no");
        }
      },
    );
  }
}
