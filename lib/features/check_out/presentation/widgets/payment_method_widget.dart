import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/features/check_out/cubit/select_payment_cubic.dart';
import 'package:techmart/features/check_out/models/payment_mode_model.dart';

class PaymentMethodWIdget extends StatelessWidget {
  SelectPaymentCubic paymentCubic;
  PaymentMethodWIdget({super.key, required this.paymentCubic});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Method",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        BlocBuilder<SelectPaymentCubic, PaymentMode>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  children: [
                    Radio(
                      fillColor: WidgetStateProperty.all(Colors.black),
                      value: PaymentMode.cod,
                      groupValue: state,
                      onChanged: (selected) {
                        context.read<SelectPaymentCubic>().changeMode(
                          selected!,
                        );
                      },
                    ),
                    Text(
                      toString(PaymentMode.cod),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      fillColor: WidgetStateProperty.all(Colors.black),
                      value: PaymentMode.razerPay,
                      groupValue: state,
                      onChanged: (selected) {
                        context.read<SelectPaymentCubic>().changeMode(
                          selected!,
                        );
                      },
                    ),
                    Text(
                      toString(PaymentMode.razerPay),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
