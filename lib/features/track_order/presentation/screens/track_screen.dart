import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/core/utils/copy_to_clipboard_funtion.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/core/widgets/snakbar_widgert.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/chat_room/bloc/message_bloc.dart';
import 'package:techmart/features/chat_room/presention/screens/chat_screen.dart';
import 'package:techmart/features/chat_room/service/chat_room_service.dart';
import 'package:techmart/features/orders/model/order_model.dart';
import 'package:techmart/features/track_order/cubit/track_order_cubit.dart';
import 'package:techmart/features/track_order/model/order_status.dart';
import 'package:techmart/features/track_order/presentation/widgets/need_help_widget.dart';
import 'package:techmart/features/track_order/service/track_order_service.dart';
import 'package:techmart/features/track_order/widgets/order_tracking_timeline_widget.dart';
import 'package:techmart/features/track_order/widgets/tracking_widget.dart';

class TrackScreen extends StatelessWidget {
  final OrderModel order;
  // final String productImage;
  // final String productName;
  const TrackScreen({
    super.key,
    required this.order,
    // required this.productImage,
    // required this.productName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custemAppbar(heading: "Track Order", context: context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order ID",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "#${order.orderId.toUpperCase()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await copyToClipBoard(order.orderId, context);
                  },
                  icon: Icon(Icons.copy, color: Colors.blueGrey),
                ),
              ],
            ),
            const VerticalSpaceWisget(8),
            Divider(),
            const VerticalSpaceWisget(8),
            Text(
              formatStep(order.status),
              style: GoogleFonts.lato(
                fontSize: 38,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),

            const SizedBox(height: 16),

            OrderTrackingTimeline(
              data: order,
              // status: order.status,
              // updatedAt: order.updateTime?.toIso8601String() ?? '',
            ),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                          future: TrackOrderService().fetchPRoductNameAndImage(
                            order.productId,
                            order.varientId,
                          ),
                          builder: (context, asyncSnapshot) {
                            if (asyncSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (asyncSnapshot.hasError) {
                              log(
                                "Error loading product info: ${asyncSnapshot.error}",
                              );
                              return Center(
                                child: Text("Error loading product info"),
                              );
                            }
                            // final data = asyncSnapshot.data;
                            // if (data == null ||
                            //     data["image"] == null ||
                            //     data["ProductName"] == null) {

                            //   return Center(child: Text("No product info found"));
                            // }
                            return Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(6),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    asyncSnapshot.data!["image"]!,
                                  ),

                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder(
                                future: TrackOrderService()
                                    .fetchPRoductNameAndImage(
                                      order.productId,
                                      order.varientId,
                                    ),

                                builder: (context, asyncSnapshot) {
                                  if (asyncSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    Text("Loading");
                                  }
                                  if (asyncSnapshot.hasError) {
                                    return Text("nopreocut Foudn");
                                  }
                                  if (!asyncSnapshot.hasData) {
                                    return Center(
                                      child: Text("Error loading product info"),
                                    );
                                  }
                                  return Text(
                                    asyncSnapshot.data!["ProductName"]!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Qty: ${order.quantity}",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Shipping Address",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    order.address.fullAddressWithName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    "Payment Type",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // const Text("Express Delivery"),
                  Text(
                    order.paymentMode,
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),

                  const HorizontalSpaceWisget(10),
                  NeedHelpButton(sellerId: order.sellerId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
