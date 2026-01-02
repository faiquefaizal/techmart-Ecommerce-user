import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/utils/price_formater.dart';
import 'package:techmart/core/utils/text_util.dart/capitalizse_text.dart';
import 'package:techmart/features/home_page/utils/text_util.dart';
import 'package:techmart/features/orders/model/order_card_model.dart';
import 'package:techmart/features/track_order/cubit/track_order_cubit.dart';
import 'package:techmart/features/track_order/presentation/screens/order_track.dart';
import 'package:techmart/features/track_order/service/track_order_service.dart';

class OngoingOrderCard extends StatelessWidget {
  final OrderCardModel cartModel;

  const OngoingOrderCard({super.key, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    log(cartModel.toString());

    double cardSized = 130;

    return SizedBox(
      height: cardSized,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade100),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        color: Colors.white,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 90,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey, width: 0.8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(8),
                      child: Image.network(cartModel.image, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              captilize(cartModel.productName),
                              textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false,
                                applyHeightToLastDescent: false,
                              ),
                              style: Theme.of(context).textTheme.labelMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                cartModel.status,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Text(
                          cartModel.attibute.entries
                              .map((value) => "${value.key}: ${value.value}")
                              .join(" • "),
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black54,
                          ),
                        ),

                        Spacer(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                formatIndianPrice(
                                  double.parse(cartModel.total).toInt(),
                                ),
                                style: CustomTextStyles.cartCardPrice,
                              ),
                              Spacer(),
                              Material(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black,
                                child: InkWell(
                                  splashColor: Colors.black45,
                                  borderRadius: BorderRadius.circular(5),
                                  highlightColor: Colors.grey.shade300,
                                  onTap: () {
                                    context
                                        .read<TrackOrderCubit>()
                                        .getOrderStatus(cartModel.id);
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder:
                                    //         (context) => BlocProvider(
                                    //           create:
                                    //               (context) => TrackOrderCubit(
                                    //                 TrackOrderService(),
                                    //               )..getOrderStatus(
                                    //                 cartModel.id,
                                    //               ),
                                    //           child: OrderTrack(),
                                    //         ),
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 95,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black26),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      "Track Order",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
