import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:techmart/features/rating/cubit/rating_cubit.dart';

RatingBar ratingWidget(BuildContext context) {
  return RatingBar(
    initialRating: context.read<RatingCubit>().state,
    allowHalfRating: true,
    itemSize: 45,
    itemPadding: EdgeInsetsGeometry.all(4),
    ratingWidget: RatingWidget(
      full: Icon(Icons.star, color: const Color.fromRGBO(255, 153, 0, 100)),
      half: Icon(
        Icons.star_half,
        color: const Color.fromRGBO(255, 153, 0, 100),
      ),
      empty: Icon(Icons.star_border, color: Colors.grey),
    ),
    onRatingUpdate: (value) {
      context.read<RatingCubit>().tapRating(value);
    },
  );
}
