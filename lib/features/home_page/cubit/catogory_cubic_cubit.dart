import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techmart/features/home_page/models/catagory_model.dart';
import 'package:techmart/features/home_page/service/catagory_service.dart';

part 'catogory_cubic_state.dart';

class CatogoryCubicCubit extends Cubit<CatogoryCubicState> {
  StreamSubscription<List<CategoryModel>>? _streamSubscription;
  CatogoryCubicCubit() : super(CatogoryCubicInitial());

  void fetchCatagories() async {
    emit(CatagoryCubicLoading());
    // await Future.delayed(Duration(seconds: 1));
    _streamSubscription?.cancel();
    _streamSubscription = CatagoryService().fetchCatagories().listen((
      catagories,
    ) {
      final firstId = catagories.first.categoryuid;

      emit(CatagoryCubicLoaded(catagoryList: catagories, selectedId: firstId));
    });
  }

  void selectcatagory(String catagoryid) {
    if (state is CatagoryCubicLoaded) {
      emit(
        CatagoryCubicLoaded(
          catagoryList: (state as CatagoryCubicLoaded).catagoryList,
          selectedId: catagoryid,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
