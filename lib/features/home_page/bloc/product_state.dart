part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

class ProductLoadSuccess extends ProductState {
  final ProductModel product;
  final ProductVarientModel selectedVariant;

  ProductLoadSuccess(this.product, this.selectedVariant);
}
