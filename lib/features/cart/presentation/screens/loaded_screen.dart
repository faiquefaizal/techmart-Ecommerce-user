import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/core/widgets/label_align_price.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/cart/bloc/cart_bloc.dart';
import 'package:techmart/features/cart/presentation/widget/cart_product_widget.dart';
import 'package:techmart/features/cart/presentation/widget/go_to_checkout.dart';
import 'package:techmart/features/check_out/cubit/select_payment_cubic.dart';
import 'package:techmart/features/check_out/cubit/selected_address_cubit.dart';
import 'package:techmart/features/check_out/presentation/screens/check_out_page.dart';
import 'package:techmart/features/coupen/cubit/coupen_cubit.dart';
import 'package:techmart/features/coupen/services/coupen_services.dart';

class CartLoadedScreen extends StatelessWidget {
  const CartLoadedScreen({
    super.key,
    required this.subtotal,
    required this.totalDiscount,
    required this.shippingCharge,
    required this.total,
    required this.sellerByMap,
    required this.state,
  });
  final CartLoaded state;
  final String subtotal;
  final String totalDiscount;
  final int shippingCharge;
  final int total;
  final Map<String, double> sellerByMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custemAppbar(heading: "My Cart", context: context),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: AnimationLimiter(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = state.cartItems[index];

                    return AnimationConfiguration.staggeredList(
                      position: index,

                      child: SlideAnimation(
                        duration: Duration(seconds: 1),
                        verticalOffset: -100,
                        child: CustomProductCard(cartModel: cartItem),
                      ),
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      LabelAlignPriceWidget(value: subtotal, label: "Subtotal"),
                      const VerticalSpaceWisget(5),

                      LabelAlignPriceWidget(
                        value: totalDiscount,
                        label: "Discount",
                      ),
                      const VerticalSpaceWisget(5),

                      LabelAlignPriceWidget(
                        value: shippingCharge.toString(),
                        label: "Shippin Charge",
                      ),
                      const VerticalSpaceWisget(5),
                      const Divider(),
                      const VerticalSpaceWisget(5),
                      HeadLabelAlignPriceWidget(
                        value: total.toString(),
                        label: "Total",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: GoTOCheckOut(total: total, sellerByMap: sellerByMap),
    );
  }
}
