import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/features/coupen/cubit/coupen_cubit.dart';
import 'package:techmart/features/orders/bloc/order_bloc.dart';
import 'package:techmart/features/orders/presentation/cubit/select_cubit.dart';
import 'package:techmart/features/orders/presentation/presentation/screens/completed_screen.dart';
import 'package:techmart/features/orders/presentation/presentation/screens/empty_orders_screen.dart';
import 'package:techmart/features/orders/presentation/presentation/screens/ongoing_screen.dart';
import 'package:techmart/features/orders/presentation/presentation/screens/shimmer_completed_order.dart';
import 'package:techmart/features/orders/presentation/widgets/tab_bar_widget.dart';
import 'package:techmart/features/orders/service/order_service.dart';
import 'package:techmart/features/track_order/cubit/track_order_cubit.dart';
import 'package:techmart/features/track_order/presentation/screens/order_details_screen.dart';
import 'package:techmart/features/track_order/presentation/screens/track_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = context.watch<TabSelectCubic>().state;
    return BlocListener<TrackOrderCubit, TrackOrderState>(
      listener: (context, state) {
        if (state is OrderTrackingState) {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => TrackScreen(
                    order: state.order,
                    // productImage: state.productImage,
                    // productName: state.productName,
                  ),
            ),
          );
        }
        if (state is OrderDetails) {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => OrderDetailsScreen(
                    orderModel: state.order,
                    productDetails: state.productInfo,
                  ),
            ),
          );
        }
        if (state is LoadingOrder || state is IntialState) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder:
                (context) => LoadingAnimationWidget.inkDrop(
                  color: Colors.black,
                  size: 50,
                ),
          );
        }
      },
      child: Scaffold(
        appBar: custemAppbar(heading: "My Orders", context: context),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: BlocBuilder<FetchOrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return ShimmerCompletedCard();
              }
              if (state is EmptyOrders) {
                return EmptyOrdersScreen();
              }
              return Column(
                children: [
                  TabBarWidget(selectedIndex: selectedIndex),
                  Expanded(
                    child: IndexedStack(
                      index: selectedIndex,
                      children: [OngoingScreen(), CompletedScreen()],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
