part of 'product_bloc.dart';

@immutable
sealed class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductLoaded extends ProductEvent {
  final ProductModel product;
  ProductLoaded(this.product);
  @override
  List<Object?> get props => [product];
}

class VariantSelected extends ProductEvent {
  final ProductVarientModel variant;

  VariantSelected(this.variant);

  @override
  List<Object?> get props => [variant];
}

class SearchProduct extends ProductEvent {
  final String productName;
  SearchProduct({required this.productName});
  @override
  List<Object?> get props => [productName];
}

class _ProductsFetched extends ProductEvent {
  final List<ProductModel> products;
  _ProductsFetched(this.products);
  @override
  List<Object?> get props => [products];
}

class _SearchFailed extends ProductEvent {
  final String error;
  _SearchFailed(this.error);
  @override
  List<Object?> get props => [error];
}

class FileterEvent extends ProductEvent {
  final FilterState filters;
  final String catagory;
  FileterEvent({required this.filters, required this.catagory});

  @override
  List<Object?> get props => [filters];
}

class CombinedSearchAndFilter extends ProductEvent {
  final String? query;
  final FilterState? filters;
  final String? catagoryId;

  CombinedSearchAndFilter({this.query, this.filters, this.catagoryId});

  @override
  List<Object?> get props => [query, filters];
}

class SearchVisually extends ProductEvent {
  TextEditingController controller;
  SearchVisually({required this.controller});
}
