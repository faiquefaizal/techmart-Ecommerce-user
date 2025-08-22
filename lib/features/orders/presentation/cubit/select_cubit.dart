import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TabSelectCubic extends Cubit<int> {
  TabSelectCubic() : super(0);
  void selected(int index) {
    emit(index);
  }
}
