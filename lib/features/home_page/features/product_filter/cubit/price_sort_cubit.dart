import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techmart/features/home_page/features/product_filter/model/price_sort_enum.dart';

class PriceSortCubit extends Cubit<PriceSort?> {
  PriceSortCubit() : super(null);
  void selectChip(PriceSort sort) {
    if (state == sort) {
      emit(null);
    } else {
      emit(sort);
    }
  }
}
