part of 'adderss_bloc.dart';

sealed class AdderssState extends Equatable {
  const AdderssState();

  @override
  List<Object> get props => [];
}

final class AdderssInitial extends AdderssState {}

final class AddressLoaded extends AdderssState {
  final List<AddressModel?> addressList;
  const AddressLoaded({required this.addressList});
  @override
  List<Object> get props => [addressList];
}

final class EmptyAddress extends AdderssState {}

final class AddressLoading extends AdderssState {}

final class AdderessError extends AdderssState {
  final String error;
  const AdderessError({required this.error});
}
