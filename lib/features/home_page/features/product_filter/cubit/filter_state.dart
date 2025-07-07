part of 'filter_cubit.dart';

class FilterState extends Equatable {
  final String selectedBrandId;
  final PriceSort? sortBy;
  final RangeValues priceRange;
  final List<BrandModel> brandList;
  const FilterState({
    required this.selectedBrandId,
    this.sortBy,
    required this.priceRange,
    this.brandList = const [],
  });

  FilterState copyWith({
    String? selectedBrandId,
    PriceSort? sortBy,
    RangeValues? priceRange,
    List<BrandModel>? brandList,
  }) {
    return FilterState(
      selectedBrandId: selectedBrandId ?? this.selectedBrandId,
      sortBy: sortBy ?? this.sortBy,
      priceRange: priceRange ?? this.priceRange,
      brandList: brandList ?? this.brandList,
    );
  }

  @override
  List<Object?> get props => [selectedBrandId, sortBy, priceRange, brandList];
}
