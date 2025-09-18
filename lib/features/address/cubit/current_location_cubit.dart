import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:pdf/widgets.dart';
import 'package:techmart/features/address/cubit/current_address_cubit/current_address_cubic_cubit.dart';
import 'package:techmart/features/address/service/user_current_location.dart';

part 'current_location_state.dart';

class CurrentLocationCubit extends Cubit<CurrentLocationState> {
  CurrentAddressCubicCubit addressCubicCubit;
  CurrentLocationCubit(this.addressCubicCubit)
    : super(CurrentLocationInitial());
  void fillLocationFilleds() async {
    try {
      emit(LoadingState());
      final pos = await UserCurrentLocationService.getCurrentLocation();
      final address =
          await UserCurrentLocationService.getAddressBasedOnPosition(pos);
      log(address.toString());
      addressCubicCubit.fillWIthcurrentLocation(address);
      emit(LocationSuccess());
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
