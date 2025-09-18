// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:techmart/features/address/models/address_model.dart';
// import 'package:techmart/features/address/service/user_current_location.dart';
// import 'package:techmart/features/chat_room/bloc/message_bloc.dart';

// part 'current_address_cubic_state.dart';

// class CurrentAddressCubicCubit extends Cubit<CurrentAddressCubicState> {
//   CurrentAddressCubicCubit() : super(CurrentAddressCubicState());
//   void updateFullName(String value) => emit(state.copyWith(fullName: value));

//   void updatePhone(String value) => emit(state.copyWith(phoneNumber: value));

//   void updatePin(String value) => emit(state.copyWith(pinCode: value));

//   void updateState(String value) => emit(state.copyWith(state: value));

//   void updateCity(String value) => emit(state.copyWith(city: value));

//   void updateHouse(String value) => emit(state.copyWith(houseNo: value));

//   void updateArea(String value) => emit(state.copyWith(area: value));

//   void toggleIsDefault(bool value) => emit(state.copyWith(isDefault: value));
//   intializeWithAddress(AddressModel address) {
//     emit(
//       CurrentAddressCubicState(
//         id: address.id ?? "no id y",
//         fullName: address.fullName,
//         phoneNumber: address.phoneNumber,
//         area: address.area,
//         pinCode: address.pinCode,
//         state: address.state,
//         houseNo: address.houseNo,
//         city: address.city,
//         isDefault: address.isDefault,
//       ),
//     );
//   }

//   void fillWIthcurrentLocation(Placemark address) {
//     log("addressFillStateeimited");
//     emit(
//       state.copyWith(
//         area: address.subLocality ?? "",
//         pinCode: address.postalCode ?? "",
//         state: address.administrativeArea ?? "",
//         houseNo: address.name ?? "",
//         city: address.locality ?? "",
//       ),
//     );
//   }

//   void fillWithMapData(Placemark address) {
//     emit(
//       state.copyWith(
//         area: address.name,
//         pinCode: address.postalCode ?? "",
//         state: address.administrativeArea ?? "",

//         city: address.locality ?? "",
//       ),
//     );
//   }

//   void clear() {
//     emit(
//       CurrentAddressCubicState(
//         fullName: '',
//         phoneNumber: '',
//         area: '',
//         pinCode: '',
//         state: '',
//         houseNo: '',
//         city: '',
//         isDefault: false,
//       ),
//     );
//   }
// }
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:equatable/equatable.dart';
import 'package:techmart/features/address/models/address_model.dart';
import 'package:techmart/features/address/service/user_current_location.dart';

part 'current_address_cubic_state.dart';

class CurrentAddressCubicCubit extends Cubit<CurrentAddressCubicState> {
  // Text controllers
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final pinController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final houseController = TextEditingController();
  final areaController = TextEditingController();
  final String? id;

  bool isDefault = false;

  CurrentAddressCubicCubit({this.id}) : super(CurrentAddressCubicState());

  /// Toggle default flag
  void toggleIsDefault(bool value) {
    isDefault = value;
    emit(state.copyWith(isDefault: value));
  }

  /// Initialize from a saved address
  void initializeWithAddress(AddressModel address) {
    fullNameController.text = address.fullName ?? '';
    phoneController.text = address.phoneNumber ?? '';
    pinController.text = address.pinCode ?? '';
    stateController.text = address.state ?? '';
    cityController.text = address.city ?? '';
    houseController.text = address.houseNo ?? '';
    areaController.text = address.area ?? '';
    isDefault = address.isDefault;
  }

  Future<void> fillWIthcurrentLocation(Placemark address) async {
    areaController.text = address.subLocality ?? '';
    pinController.text = address.postalCode ?? '';
    stateController.text = address.administrativeArea ?? '';
    houseController.text = address.name ?? '';
    cityController.text = address.locality ?? '';
  }

  void fillWithMapData(Placemark address) {
    areaController.text = address.name ?? '';
    pinController.text = address.postalCode ?? '';
    stateController.text = address.administrativeArea ?? '';
    cityController.text = address.locality ?? '';
  }

  void clear() {
    fullNameController.clear();
    phoneController.clear();
    pinController.clear();
    stateController.clear();
    cityController.clear();
    houseController.clear();
    areaController.clear();
    isDefault = false;
    emit(CurrentAddressCubicState(isDefault: false));
  }

  AddressModel toAddressModel() {
    return AddressModel(
      id: id,
      fullName: fullNameController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      pinCode: pinController.text.trim(),
      state: stateController.text.trim(),
      city: cityController.text.trim(),
      houseNo: houseController.text.trim(),
      area: areaController.text.trim(),
      isDefault: isDefault,
    );
  }

  @override
  Future<void> close() {
    fullNameController.dispose();
    phoneController.dispose();
    pinController.dispose();
    stateController.dispose();
    cityController.dispose();
    houseController.dispose();
    areaController.dispose();
    return super.close();
  }
}
