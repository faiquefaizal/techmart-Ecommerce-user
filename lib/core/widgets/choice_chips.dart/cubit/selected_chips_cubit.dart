import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class SelectedChipsCubit extends Cubit<String> {
  SelectedChipsCubit() : super("All");

  void selectChoips(String value) {
    emit(value);
  }
}
