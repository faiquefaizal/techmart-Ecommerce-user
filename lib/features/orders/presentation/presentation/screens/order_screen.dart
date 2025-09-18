import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/features/orders/bloc/order_bloc.dart';
import 'package:techmart/features/orders/presentation/cubit/select_cubit.dart';
import 'package:techmart/features/orders/presentation/presentation/screens/completed_screen.dart';
import 'package:techmart/features/orders/presentation/presentation/screens/empty_orders_screen.dart';
import 'package:techmart/features/orders/presentation/presentation/screens/ongoing_screen.dart';
import 'package:techmart/features/orders/presentation/presentation/screens/shimmer_completed_order.dart';
import 'package:techmart/features/orders/presentation/widgets/tab_bar_widget.dart';
import 'package:techmart/features/orders/service/order_service.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = context.watch<TabSelectCubic>().state;
    return Scaffold(
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
    );
  }
}
