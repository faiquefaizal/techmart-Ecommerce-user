part of 'product_bloc.dart';

@immutable
sealed class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {
  final List<ProductModel> products;

  ProductLoading(this.products);
  @override
  List<Object?> get props => [products];
}

class ProductLoadSuccess extends ProductState {
  final ProductModel product;
  final List<ProductVarientModel> vairents;
  final ProductVarientModel selectedVariant;
  final Map<String, dynamic>? rating;

  ProductLoadSuccess({
    required this.product,
    required this.selectedVariant,
    required this.vairents,
    this.rating,
  });
  @override
  List<Object?> get props => [product, selectedVariant];
}

class ProductSearchError extends ProductState {
  final String message;
  ProductSearchError(this.message);
  @override
  List<Object?> get props => [message];
}

final class ProductSearchNotFound extends ProductState {}

class CombinedProductLoading extends ProductState {
  final List<ProductModel> products;
  final String query;
  final FilterState filters;

  CombinedProductLoading(this.products, this.query, this.filters);

  @override
  List<Object?> get props => [products, query, filters];
}

class CombinedProductError extends ProductState {
  final String message;
  final String query;
  final FilterState filters;

  CombinedProductError(this.message, this.query, this.filters);

  @override
  List<Object?> get props => [message, query, filters];
}

class CombinedProductLoaded extends ProductState {
  final List<ProductModel> products;
  final String query;
  final FilterState filters;

  CombinedProductLoaded(this.products, this.query, this.filters);

  @override
  List<Object?> get props => [products, query, filters];
}

final class VisualSearchLoading extends ProductState {}
