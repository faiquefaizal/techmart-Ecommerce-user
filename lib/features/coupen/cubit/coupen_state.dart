part of 'coupen_cubit.dart';

sealed class CoupenState extends Equatable {
  const CoupenState();

  @override
  List<Object> get props => [];
}

final class IntialState extends CoupenState {}

final class SuccessState extends CoupenState {
  final int discount;
  const SuccessState({required this.discount});
  @override
  List<Object> get props => [discount];
}

final class ErrorState extends CoupenState {
  final String error;
  const ErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
