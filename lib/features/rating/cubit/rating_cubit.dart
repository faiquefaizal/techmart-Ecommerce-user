import 'package:bloc/bloc.dart';

class RatingCubit extends Cubit<double> {
  RatingCubit() : super(0);
  tapRating(double tapvalue) {
    emit(tapvalue);
  }
}
