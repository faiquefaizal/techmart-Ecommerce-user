import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/utils/price_formater.dart';
import 'package:techmart/core/utils/text_util.dart/capitalizse_text.dart';
import 'package:techmart/features/cart/model/product_cart_model.dart';
import 'package:techmart/features/home_page/utils/text_util.dart';
import 'package:techmart/features/orders/bloc/order_bloc.dart';
import 'package:techmart/features/orders/model/order_model.dart';
import 'package:techmart/features/orders/presentation/presentation/screens/empty_orders_screen.dart';
import 'package:techmart/features/orders/presentation/widgets/completed_card_widget.dart';
import 'package:techmart/features/orders/presentation/widgets/ongoing_card_widget.dart';
import 'package:techmart/features/orders/utils/order_card_util.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final state = (context.watch<FetchOrderBloc>().state);

    return BlocBuilder<FetchOrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoaded) {
          return Scaffold(
            body: SingleChildScrollView(
              child: FutureBuilder(
                future: getOrderCard(state.completedOrders),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (asyncSnapshot.hasError) {
                    return Text(asyncSnapshot.error.toString());
                  }

                  if (asyncSnapshot.hasData) {
                    if (asyncSnapshot.data!.isEmpty) {
                      return EmptyOrdersScreen();
                    }
                    return ListView.builder(
                      itemCount: asyncSnapshot.data?.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final orders = asyncSnapshot.data;
                        log(orders.toString());
                        final order = orders![index];
                        log(order.toString());
                        return CompletedCardWidget(cartModel: order);
                      },
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
            // body: Column(children: [OngoingOrderCard(cartModel: cartModel)]),
          );
        } else if (state is OrderError) {
          return Center(child: Text(state.message));
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
