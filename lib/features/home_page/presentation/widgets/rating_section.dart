import 'package:flutter/material.dart';
import 'package:techmart/features/home_page/presentation/screens/ratings_card.dart';
import 'package:techmart/features/home_page/presentation/widgets/rating_count_widget.dart';

class RatingSectionWidget extends StatelessWidget {
  const RatingSectionWidget({super.key, required this.rating});

  final Map<String, dynamic>? rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ratings & Reviews",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        ReviewSection(rating: rating!),
        ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final orderModel = rating!["orderList"];
            return RatingsCard(order: orderModel);
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: (rating!["orderList"] as List).length,
        ),
      ],
    );
  }
}
