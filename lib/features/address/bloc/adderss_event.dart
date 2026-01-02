part of 'adderss_bloc.dart';

sealed class AdderssEvent extends Equatable {
  const AdderssEvent();

  @override
  List<Object> get props => [];
}

final class GetAllAddress extends AdderssEvent {}

final class AddAddressEvent extends AdderssEvent {
  final AddressModel addressModel;
  const AddAddressEvent({required this.addressModel});
}

final class EditAddressEvent extends AdderssEvent {
  final AddressModel updatedAddress;
  const EditAddressEvent({required this.updatedAddress});

  @override
  List<Object> get props => [updatedAddress];
}

final class DeleteAddressEvent extends AdderssEvent {
  final String? id;
  const DeleteAddressEvent({required this.id});
}

final class ClearEvent extends AdderssEvent {}
