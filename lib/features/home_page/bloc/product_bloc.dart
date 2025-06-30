import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:techmart/core/utils/debouncer.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';
import 'package:techmart/features/home_page/service/product_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final debounser = Debouncer(duration: Duration(milliseconds: 400));
  StreamSubscription<List<ProductModel>>? _searchSubsription;

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
    on<SearchProduct>((event, emit) async {
      debounser.run(() {
        _searchSubsription?.cancel();
        _searchSubsription = ProductService.searchWithRx(
          event.productName,
        ).listen(
          (product) {
            log("lsitned");
            if (product.isEmpty) {
              log("No products found.");
            } else {
              log("search ${product.first.toString()}");
            }
            add(_ProductsFetched(product));
          },
          onError: (error) {
            add(_SearchFailed(error.toString()));
          },
        );
      });
    });
    on<_ProductsFetched>((event, emit) {
      if (event.products.isEmpty) {
        emit(ProductSearchNotFound());
      } else {
        emit(ProductLoading(event.products));
      }
    });

    on<_SearchFailed>((event, emit) {
      emit(ProductSearchError(event.error));
    });
  }
}
