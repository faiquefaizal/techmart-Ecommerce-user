import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'dart:async';
import 'package:techmart/core/utils/debouncer.dart';
import 'package:techmart/features/home_page/cubit/catogory_cubic_cubit.dart';
import 'package:techmart/features/home_page/features/product_filter/cubit/filter_cubit.dart';
//  import 'package:techmart/features/home_page/features/visual_search/service/viusal_search.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';
import 'package:techmart/features/home_page/service/product_service.dart';
import 'package:techmart/features/orders/service/order_service.dart';
import 'package:techmart/features/visual_search/service/viusal_search.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final debounser = Debouncer(duration: Duration(milliseconds: 400));
  StreamSubscription<List<ProductModel>>? _searchSubsription;

  ProductBloc() : super(ProductInitial()) {
    print(" ProductBloc constructed");
    on<SearchVisually>((event, emit) async {
      Future.delayed(Duration(seconds: 3));
      emit(VisualSearchLoading());

      try {
        final result = await runVisualSearch();

        if (result != null) {
          final query =
              "${result.safeCategory} ${result.safeModel} ${result.brandName}"
                  .trim();

          event.controller.text = query;
          Logger().d("resutlModel :${result.toString()}");
          Logger().w(query);
          // add(SearchProduct(productName: query));
        } else {
          log("else : failed");
          // add(_SearchFailed("Viaual Serach failed"));
        }
      } catch (e) {
        Logger().w(e.toString());
        add(_SearchFailed(e.toString()));
      }
    });
    on<ProductLoaded>((event, emit) async {
      final varients = await ProductService.getVariantsForProduct(
        event.product.productId,
      );
      if (varients.isEmpty) {
        emit(ProductSearchError(("No variants available")));
      }
      final rating = await OrderService().getOrderRatingWIthProduct(
        event.product.productId,
        varients.first.varientId!,
      );
      emit(
        ProductLoadSuccess(
          product: event.product,
          vairents: varients,
          selectedVariant: varients.first,
          rating: rating,
        ),
      );
    });
    on<VariantSelected>((event, emit) async {
      if (state is ProductLoadSuccess) {
        final current = state as ProductLoadSuccess;
        final rating = await OrderService().getOrderRatingWIthProduct(
          current.product.productId,
          event.variant.varientId!,
        );
        emit(
          ProductLoadSuccess(
            product: current.product,
            vairents: current.vairents,
            selectedVariant: event.variant,
            rating: rating,
          ),
        );
      }
    });
    on<SearchProduct>((event, emit) async {
      print(" SearchProduct event handled");
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
      Logger().d("called fetch");
      if (event.products.isEmpty) {
        emit(ProductSearchNotFound());
      } else {
        emit(ProductLoading(event.products));
      }
    });

    on<_SearchFailed>((event, emit) {
      log(event.error);
      emit(ProductSearchError(event.error));
    });
    on<FileterEvent>((event, emit) async {
      _searchSubsription?.cancel(); // cancel previous
      emit(ProductInitial());

      _searchSubsription = ProductService.filterProdoct(
        event.filters,
        event.catagory,
      ).listen(
        (products) {
          if (products.isEmpty) {
            log("No products found.");
          } else {
            log("search ${products.first.toString()}");
          }
          add(_ProductsFetched(products));
        },
        onError: (error) {
          log(error.toString());
          add(_SearchFailed(error.toString()));
        },
      );
    });
    on<CombinedSearchAndFilter>((event, emit) {
      Logger().w("bloc triggerd");
      _searchSubsription?.cancel();

      _searchSubsription = ProductService.searchAndFilter(
        query: event.query,
        filter: event.filters,
        catagoryId: event.catagoryId,
      ).listen(
        (products) {
          Logger().w(" Products fetched in BLoC");
          for (var p in products) {
            Logger().w(" ${p.productId} | ${p.productName} | ₹${p.minPrice}");
          }
          Logger().w("${event.catagoryId}");
          add(_ProductsFetched(products));
        },
        onError: (error) {
          Logger().e(error.toString());
          add(_SearchFailed(error.toString()));
        },
      );
    });
  }
}
