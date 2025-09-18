part of 'catogory_cubic_cubit.dart';

sealed class CatogoryCubicState extends Equatable {
  const CatogoryCubicState();

  @override
  List<Object> get props => [];
}

final class CatogoryCubicInitial extends CatogoryCubicState {}

final class CatagoryCubicLoading extends CatogoryCubicState {
  String? id;
  CatagoryCubicLoading({this.id});
}

final class CatagoryCubicLoaded extends CatogoryCubicState {
  final List<CategoryModel> catagoryList;
  final String selectedId;
  const CatagoryCubicLoaded({
    required this.catagoryList,
    required this.selectedId,
  });
  @override
  List<Object> get props => [selectedId];
}
