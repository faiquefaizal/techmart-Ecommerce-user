import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ImageIndexCubit extends Cubit<int> {
  ImageIndexCubit() : super(1);

  void chageIndex(int newValue) => emit(newValue);
}
