import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class RatingCubit extends Cubit<double> {
  RatingCubit() : super(0);
  tapRating(double tapvalue) {
    emit(tapvalue);
  }
}
