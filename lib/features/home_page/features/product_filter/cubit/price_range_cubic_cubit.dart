import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PriceRangeCubicCubit extends Cubit<RangeValues> {
  PriceRangeCubicCubit() : super(RangeValues(300, 15000));

  void updateSlider(RangeValues range) {
    emit(range);
  }
}
