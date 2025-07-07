import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:techmart/features/home_page/features/product_filter/cubit/filter_cubit.dart';
import 'package:techmart/features/home_page/service/product_service.dart';

class BrandChoicChips extends StatelessWidget {
  const BrandChoicChips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        final brands = state.brandList;
        final brandId = state.selectedBrandId;
        if (brands.isEmpty) {
          return Text("Loading");
        }
        return Wrap(
          spacing: 5,
          children: [
            ChoiceChip(
              label: Text(
                "All",
                style: TextStyle(
                  fontSize: 13,
                  color: brandId == "" ? Colors.white : Colors.black,
                ),
              ),
              selected: brandId == "",
              onSelected: (_) {
                context.read<FilterCubit>().selectBrand("");
              },
              backgroundColor: Colors.white,
              selectedColor: Colors.black,
            ),
            ...brands.map((brand) {
              final isSelected = brandId == brand.brandUid;
              return ChoiceChip(
                backgroundColor: Colors.white,
                selectedColor: Colors.black,
                label: Text(
                  brand.name,
                  style: TextStyle(
                    fontSize: 13,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    context.read<FilterCubit>().selectBrand(brand.brandUid);
                  }
                },
              );
            }),
          ],
        );
      },
    );
  }
}
