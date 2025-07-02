import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:techmart/features/home_page/features/product_filter/model/price_sort_enum.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit()
    : super(
        FilterState(
          priceRange: RangeValues(0, 100000),
          selectedBrandId: "",
          sortBy: PriceSort.lowToHigh,
        ),
      );

  void selectBrand(String? brandId) {
    log('Selected brand ID: $brandId');

    emit(state.copyWith(selectedBrandId: brandId));
  }

  void setSort(PriceSort? sortBy) {
    emit(state.copyWith(sortBy: sortBy));
  }

  void setPriceRange(RangeValues range) {
    emit(state.copyWith(priceRange: range));
  }

  void clearFilters() {
    emit(FilterState(priceRange: const RangeValues(0, 100000)));
  }
}
