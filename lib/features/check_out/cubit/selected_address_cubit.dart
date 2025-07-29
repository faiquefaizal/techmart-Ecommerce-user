import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedAddressCubit extends Cubit<String?> {
  SelectedAddressCubit() : super(null);

  void selectId(String id) {
    emit(id);
  }
}
