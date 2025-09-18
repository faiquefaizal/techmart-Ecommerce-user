import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/features/check_out/cubit/select_payment_cubic.dart';
import 'package:techmart/features/check_out/cubit/selected_address_cubit.dart';
import 'package:techmart/features/check_out/presentation/screens/check_out_page.dart';
import 'package:techmart/features/coupen/cubit/coupen_cubit.dart';
import 'package:techmart/features/coupen/services/coupen_services.dart';

class GoTOCheckOut extends StatelessWidget {
  const GoTOCheckOut({
    super.key,
    required this.total,
    required this.sellerByMap,
  });

  final int total;
  final Map<String, double> sellerByMap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustemButton(
        hieght: 55,
        label: "Go to Checkout",
        onpressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => SelectedAddressCubit()),
                      BlocProvider(create: (context) => SelectPaymentCubic()),
                      BlocProvider(
                        create: (context) => CoupenCubit(CoupenServices()),
                      ),
                    ],
                    child: CheckoutPage(total: total, sellerByMap: sellerByMap),
                  ),
            ),
          );
        },
      ),
    );
  }
}
