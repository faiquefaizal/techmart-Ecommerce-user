part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class ProductLoaded extends ProductEvent {
  final ProductModel product;
  ProductLoaded(this.product);
}

class VariantSelected extends ProductEvent {
  final ProductVarientModel variant;
  VariantSelected(this.variant);
}

class SearchProduct extends ProductEvent {
  final String productName;
  SearchProduct({required this.productName});
}
