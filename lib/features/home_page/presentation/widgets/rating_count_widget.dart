import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/features/home_page/utils/text_util.dart';
import 'package:techmart/features/orders/model/order_model.dart';

class RatingCountWidget extends StatelessWidget {
  final Map<String, dynamic> rating;
  const RatingCountWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    log(rating["avg"]);
    return Row(
      children: [
        Icon(Icons.star, color: Color.fromRGBO(255, 153, 0, 100)),
        Text(
          style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
          "${rating["avg"]}",
        ),

        Text(
          "(${(rating["orderList"] as List).length.toString()} Reviews)",
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class ReviewSection extends StatelessWidget {
  final Map<String, dynamic> rating;
  const ReviewSection({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              rating["avg"],
              style: Theme.of(context).textTheme.displaySmall,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBar(
                    initialRating: double.parse(rating["avg"]),
                    allowHalfRating: true,
                    itemSize: 30,

                    ratingWidget: RatingWidget(
                      full: Icon(
                        Icons.star,
                        color: const Color.fromRGBO(255, 153, 0, 100),
                      ),
                      half: Icon(
                        Icons.star_half,
                        color: const Color.fromRGBO(255, 153, 0, 100),
                      ),
                      empty: SizedBox.shrink(),
                    ),
                    onRatingUpdate: (_) {},
                  ),
                  Text(
                    "${(rating["orderList"] as List).length.toString()} Reviews",
                    style: GoogleFonts.lato(color: Colors.grey, fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
