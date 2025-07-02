import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:techmart/core/utils/debouncer.dart';
import 'package:techmart/features/home_page/features/product_filter/cubit/filter_cubit.dart';
import 'package:techmart/features/home_page/features/visual_search/service/viusal_search.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';
import 'package:techmart/features/home_page/service/product_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final debounser = Debouncer(duration: Duration(milliseconds: 400));
  StreamSubscription<List<ProductModel>>? _searchSubsription;

  ProductBloc() : super(ProductInitial()) {
    on<ProductLoaded>((event, emit) async {
      final varients = await ProductService.getVariantsForProduct(
        event.product.productId,
      );
      if (varients.isEmpty) {
        emit(ProductSearchError(("No variants available")));
      }
      emit(
        ProductLoadSuccess(
          product: event.product,
          vairents: varients,
          selectedVariant: varients.first,
        ),
      );
    });
    on<VariantSelected>((event, emit) {
      if (state is ProductLoadSuccess) {
        final current = state as ProductLoadSuccess;
        emit(
          ProductLoadSuccess(
            product: current.product,
            vairents: current.vairents,
            selectedVariant: event.variant,
          ),
        );
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

    // on<VisualSearch>((event, emit) async {
    //   emit(ProductInitial());

    //   final result = await runVisualSearch();
    //   if (result == null) {
    //     emit(ProductSearchNotFound());
    //     return;
    //   }

    //   final searchQuery =
    //       "${result.brandName} ${result.catagory} ${result.modelName}".trim();

    //   if (searchQuery.isEmpty) {
    //     emit(ProductSearchNotFound());
    //     return;
    //   }

    //   ProductService.searchWithRx(searchQuery).listen(
    //     (products) {
    //       if (products.isEmpty) {
    //         emit(ProductSearchNotFound());
    //       } else {
    //         emit(ProductLoading(products));
    //       }
    //     },
    //     onError: (error) {
    //       emit(ProductSearchError(error.toString()));
    //     },
    //   );
    // });

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
    on<FileterEvent>((event, emit) async {
      _searchSubsription?.cancel(); // cancel previous
      emit(ProductInitial());

      _searchSubsription = ProductService.filterProdoct(event.filters).listen(
        (products) {
          if (products.isEmpty) {
            log("No products found.");
          } else {
            log("search ${products.first.toString()}");
          }
          add(_ProductsFetched(products));
        },
        onError: (error) {
          add(_SearchFailed(error.toString()));
        },
      );
    });
  }
}
