import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/coupen_add_buttom_widget.dart';
import 'package:techmart/core/widgets/snakbar_widgert.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/coupen/cubit/coupen_cubit.dart';

class CoupenWidget extends StatelessWidget {
  final GlobalKey<FormState> formkey;
  final TextEditingController coupenController = TextEditingController();
  final int total;
  final Map<String, double> sellerList;
  CoupenWidget({
    super.key,
    required this.total,
    required this.sellerList,
    required this.formkey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: SizedBox(
            height: 50,
            child: BlocConsumer<CoupenCubit, CoupenState>(
              listener: (context, state) {
                if (state is SuccessState) {
                  custemSnakbar(
                    context: context,
                    message: "Coupen Added ",
                    color: Colors.green,
                  );
                }
              },
              builder: (context, state) {
                return Form(
                  key: formkey,
                  child: TextFormField(
                    controller: coupenController,
                    decoration: InputDecoration(
                      errorText: (state is ErrorState) ? state.error : null,
                      hintText: "Enter promo code",
                      prefixIcon: Icon(
                        Icons.local_offer_outlined,
                        color: Colors.grey.shade300,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 217, 255, 0),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        HorizontalSpaceWisget(15),
        Expanded(
          flex: 1,
          child: CustemAddCoupoupenButton(
            label: "Add",
            onpressed: () {
              log(coupenController.text);
              context.read<CoupenCubit>().addCoupen(
                couponCode: coupenController.text.toLowerCase(),
                cartTotal: total.toDouble(),
                sellerTotals: sellerList,
              );
            },
            hieght: 50,
          ),
        ),
      ],
    );
  }
}
