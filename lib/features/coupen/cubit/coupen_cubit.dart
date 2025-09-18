import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:techmart/features/check_out/funtions/helper_funtion.dart';
import 'package:techmart/features/coupen/services/coupen_services.dart';

part 'coupen_state.dart';

class CoupenCubit extends Cubit<CoupenState> {
  CoupenServices coupenServices;
  CoupenCubit(this.coupenServices) : super(IntialState());
  void addCoupen({
    required String couponCode,
    required double cartTotal,
    required Map<String, double> sellerTotals,
  }) async {
    try {
      log("$couponCode,${cartTotal.toString()},$sellerTotals");
      final discount = await coupenServices.checkAndApplyCoupon(
        couponCode: couponCode,
        cartTotal: cartTotal,
        sellerTotals: sellerTotals,
      );
      log(discount.runtimeType.toString());
      log(discount.toInt().runtimeType.toString());
      log(discount.toInt().toString());
      emit(SuccessState(discount: discount.toInt()));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(error: removeException(e)));
    }
  }
}
