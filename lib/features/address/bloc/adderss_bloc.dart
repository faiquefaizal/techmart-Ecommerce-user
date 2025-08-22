import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techmart/features/address/models/address_model.dart';
import 'package:techmart/features/accounts/service/address_service.dart';

part 'adderss_event.dart';
part 'adderss_state.dart';

class AdderssBloc extends Bloc<AdderssEvent, AdderssState> {
  AdderssBloc() : super(AdderssInitial()) {
    on<GetAllAddress>(_getAllAddress);
    on<AddAddressEvent>(_addAddressEvent);
    on<EditAddressEvent>(_editAddressEvent);
    on<DeleteAddressEvent>(_deleteAddressEvent);
  }

  FutureOr<void> _getAllAddress(
    GetAllAddress event,
    Emitter<AdderssState> emit,
  ) async {
    emit(AddressLoading());
    try {
      final addressList = await AddressService.getAllAddressList();
      if (addressList.isEmpty) {
        emit(EmptyAddress());
      } else {
        emit(AddressLoaded(addressList: addressList));
      }
    } catch (e) {
      emit(AdderessError(error: e.toString()));
    }
  }

  FutureOr<void> _addAddressEvent(
    AddAddressEvent event,
    Emitter<AdderssState> emit,
  ) async {
    emit(AddressLoading());
    try {
      if (await AddressService.chechAddressExist()) {
        final address = await AddressService.addFirstAddress(
          event.addressModel,
        );
        emit(AddressLoaded(addressList: address));
        return;
      }
      if (event.addressModel.isDefault) {
        log('New address is default, clearing existing defaults');
        await AddressService.clearDefaultAddresses();
      }

      await AddressService.addAddress(event.addressModel);
      // Refresh the list after adding
      final addressList = await AddressService.getAllAddressList();
      emit(AddressLoaded(addressList: addressList));
    } catch (e) {
      emit(AdderessError(error: e.toString()));
    }
  }

  FutureOr<void> _editAddressEvent(
    EditAddressEvent event,
    Emitter<AdderssState> emit,
  ) async {
    emit(AddressLoading());
    try {
      if (event.updatedAddress.id == null) {
        log("No id ");
        return;
      }
      if (event.updatedAddress.isDefault) {
        log('Updated address is default, clearing existing defaults');
        await AddressService.clearDefaultAddresses();
      }
      log(event.updatedAddress.id.toString());
      await AddressService.editAddress(event.updatedAddress);
      final addressList = await AddressService.getAllAddressList();
      emit(AddressLoaded(addressList: addressList));
    } catch (e) {
      emit(AdderessError(error: e.toString()));
    }
  }

  FutureOr<void> _deleteAddressEvent(
    DeleteAddressEvent event,
    Emitter<AdderssState> emit,
  ) async {
    log("delte event called");
    emit(AddressLoading());
    try {
      if (event.id == null) {
        log("no id id is need for deleling");
        return;
      }

      await AddressService.delete(event.id!);

      final addressList = await AddressService.getAllAddressList();
      if (addressList.isEmpty) {
        emit(EmptyAddress());
      } else {
        emit(AddressLoaded(addressList: addressList));
      }
    } catch (e) {
      emit(AdderessError(error: e.toString()));
    }
  }
}
