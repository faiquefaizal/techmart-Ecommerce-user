import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techmart/features/accounts/features/address/models/address_model.dart';

part 'current_address_cubic_state.dart';

class CurrentAddressCubicCubit extends Cubit<CurrentAddressCubicState> {
  CurrentAddressCubicCubit() : super(CurrentAddressCubicState());
  void updateFullName(String value) => emit(state.copyWith(fullName: value));

  void updatePhone(String value) => emit(state.copyWith(phoneNumber: value));

  void updatePin(String value) => emit(state.copyWith(pinCode: value));

  void updateState(String value) => emit(state.copyWith(state: value));

  void updateCity(String value) => emit(state.copyWith(city: value));

  void updateHouse(String value) => emit(state.copyWith(houseNo: value));

  void updateArea(String value) => emit(state.copyWith(area: value));

  void toggleIsDefault(bool value) => emit(state.copyWith(isDefault: value));
  intializeWithAddress(AddressModel address) {
    emit(
      CurrentAddressCubicState(
        id: address.id ?? "no id y",
        fullName: address.fullName,
        phoneNumber: address.phoneNumber,
        area: address.area,
        pinCode: address.pinCode,
        state: address.state,
        houseNo: address.houseNo,
        city: address.city,
        isDefault: address.isDefault,
      ),
    );
  }

  void clear() {
    emit(
      CurrentAddressCubicState(
        fullName: '',
        phoneNumber: '',
        area: '',
        pinCode: '',
        state: '',
        houseNo: '',
        city: '',
        isDefault: false,
      ),
    );
  }
}
