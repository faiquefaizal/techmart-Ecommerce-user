import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/features/check_out/models/payment_mode_model.dart';

class SelectPaymentCubic extends Cubit<PaymentMode> {
  SelectPaymentCubic() : super(PaymentMode.cod);

  void changeMode(PaymentMode selected) {
    emit(selected);
  }
}
