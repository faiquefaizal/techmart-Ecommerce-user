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

  ProductLoadSuccess({
    required this.product,
    required this.selectedVariant,
    required this.vairents,
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
