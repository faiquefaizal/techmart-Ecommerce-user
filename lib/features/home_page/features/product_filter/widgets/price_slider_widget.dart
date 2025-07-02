import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/features/home_page/features/product_filter/cubit/filter_cubit.dart';

class PriceSliderWidget extends StatelessWidget {
  const PriceSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        final price = state.priceRange;
        return RangeSlider(
          activeColor: Colors.black,
          inactiveColor: Colors.grey[400],

          min: 0,
          max: 100000,
          labels: RangeLabels(
            "₹${price.start.toInt()}",
            "₹${price.end.toInt()}",
          ),
          divisions: 1000,
          values: RangeValues(price.start, price.end),
          onChanged: (newRange) {
            context.read<FilterCubit>().setPriceRange(newRange);
          },
        );
      },
    );
  }
}
