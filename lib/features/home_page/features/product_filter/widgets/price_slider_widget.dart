import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/features/home_page/features/product_filter/cubit/price_range_cubic_cubit.dart';

class PriceSliderWidget extends StatelessWidget {
  const PriceSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriceRangeCubicCubit, RangeValues>(
      builder: (context, state) {
        return RangeSlider(
          activeColor: Colors.black,
          inactiveColor: Colors.grey[400],

          min: 0,
          max: 100000,
          labels: RangeLabels(
            "₹${state.start.toInt()}",
            "₹${state.end.toInt()}",
          ),
          divisions: 1000,
          values: RangeValues(state.start, state.end),
          onChanged: (newRange) {
            context.read<PriceRangeCubicCubit>().updateSlider(newRange);
          },
        );
      },
    );
  }
}
