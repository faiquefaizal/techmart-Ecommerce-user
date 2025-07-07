import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/features/cart/cubit/cart_cubit.dart';
import 'package:techmart/features/cart/presentation/screens/empty_cart_screen.dart';
import 'package:techmart/features/cart/presentation/widget/cart_product_widget.dart';
import 'package:techmart/features/cart/utitl/cart_utitl.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartIsEmpty) {
          return EmptyCartScreen();
        }

        if (state is CartLoaded) {
          return Scaffold(
            appBar: custemAppbar(heading: "My Cart", context: context),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = state.cartItems[index];
                      final subtotal = getSubTotalFromCart(state.cartItems);
                      final totalDiscount = getTotalDiscounts(state.cartItems);
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            CustemProductCard(cartModel: cartItem),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Subtotal"), Text(subtotal)],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Discount"), Text(totalDiscount)],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
