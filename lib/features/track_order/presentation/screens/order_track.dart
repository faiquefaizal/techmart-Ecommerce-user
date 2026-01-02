import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:techmart/features/track_order/cubit/track_order_cubit.dart';
import 'package:techmart/features/track_order/presentation/screens/order_details_screen.dart';
import 'package:techmart/features/track_order/presentation/screens/track_screen.dart';

class OrderTrack extends StatelessWidget {
  const OrderTrack({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackOrderCubit, TrackOrderState>(
      builder: (context, state) {
        if (state is OrderTrackingState) {
          return TrackScreen(
            order: state.order,
            // productImage: state.productImage,
            // productName: state.productName,
          );
        }

        if (state is OrderDetails) {
          return OrderDetailsScreen(
            orderModel: state.order,
            productDetails: state.productInfo,
          );
        }
        if (state is TrackOrderError) {
          log(state.message);
          return Center(child: Text(state.message));
        }
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: LoadingAnimationWidget.inkDrop(
              color: Colors.black,
              size: 50,
            ),
          ),
        );
      },
    );
  }
}
