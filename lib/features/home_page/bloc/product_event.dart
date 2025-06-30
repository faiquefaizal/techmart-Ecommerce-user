part of 'product_bloc.dart';

@immutable
sealed class ProductEvent extends Equatable {}

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
