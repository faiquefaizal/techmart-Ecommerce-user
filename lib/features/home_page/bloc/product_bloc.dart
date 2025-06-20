import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductLoaded>((event, emit) {
      emit(ProductLoadSuccess(event.product, event.product.varients.first));
    });
    on<VariantSelected>((event, emit) {
      if (state is ProductLoadSuccess) {
        final current = state as ProductLoadSuccess;
        emit(ProductLoadSuccess(current.product, event.variant));
      }
    });
  }
}
