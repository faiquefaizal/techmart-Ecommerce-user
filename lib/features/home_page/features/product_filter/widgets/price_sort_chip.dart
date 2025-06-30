import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/features/home_page/features/product_filter/cubit/price_sort_cubit.dart';

import 'package:techmart/features/home_page/features/product_filter/model/price_sort_enum.dart';

class PriceSortChip extends StatelessWidget {
  const PriceSortChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriceSortCubit, PriceSort?>(
      builder: (context, state) {
        return Wrap(
          spacing: 4,
          children:
              PriceSort.values.map((sort) {
                final isSeleted = state == sort;
                return ChoiceChip(
                  label: Text(
                    getPrice(sort),
                    style: TextStyle(
                      fontSize: 13,
                      color: isSeleted ? Colors.white : Colors.black,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  selectedColor: Colors.black,
                  selected: isSeleted,
                  onSelected: (select) {
                    context.read<PriceSortCubit>().selectChip(sort);
                  },
                );
              }).toList(),
        );
      },
    );
  }
}
