part of 'filter_cubit.dart';

class FilterState extends Equatable {
  final String? selectedBrandId;
  final PriceSort? sortBy;
  final RangeValues priceRange;

  FilterState({this.selectedBrandId, this.sortBy, required this.priceRange});

  FilterState copyWith({
    String? selectedBrandId,
    PriceSort? sortBy,
    RangeValues? priceRange,
  }) {
    return FilterState(
      selectedBrandId: selectedBrandId ?? this.selectedBrandId,
      sortBy: sortBy ?? this.sortBy,
      priceRange: priceRange ?? this.priceRange,
    );
  }

  @override
  List<Object?> get props => [selectedBrandId, sortBy, priceRange];
}
