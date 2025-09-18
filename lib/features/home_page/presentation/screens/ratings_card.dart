import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/features/home_page/utils/text_util.dart';
import 'package:techmart/features/orders/model/order_model.dart';

class RatingsCard extends StatelessWidget {
  final OrderModel order;
  const RatingsCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingBar(
          itemSize: 22,
          initialRating: (order.ratingCount).toDouble(),
          ratingWidget: RatingWidget(
            full: Icon(
              Icons.star,
              color: const Color.fromRGBO(255, 153, 0, 100),
            ),
            half: Icon(
              Icons.star_half,
              color: const Color.fromRGBO(255, 153, 0, 100),
            ),
            empty: Icon(Icons.star_border, color: Colors.grey),
          ),
          onRatingUpdate: (_) {},
        ),
        VerticalDivider(),
        Text(
          order.ratingText ??
              "gklasjdgkjklfj kasdfjkjgaskldjf kldsjfkljagsf kjfdklsjfklajflkjfdas",
          style: CustomTextStyles.ratingTexts,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          spacing: 7,
          children: [
            Text(
              order.address.custemerfullname,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            Text(
              "${order.createTime.difference(DateTime.now()).inDays} days ago",
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
