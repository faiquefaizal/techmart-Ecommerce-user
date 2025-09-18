import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/snakbar_widgert.dart';
import 'package:techmart/features/address/bloc/adderss_bloc.dart';
import 'package:techmart/features/address/models/address_model.dart';
import 'package:techmart/features/cart/bloc/cart_bloc.dart';
import 'package:techmart/features/cart/model/product_cart_model.dart';
import 'package:techmart/features/check_out/cubit/select_payment_cubic.dart';
import 'package:techmart/features/check_out/cubit/selected_address_cubit.dart';
import 'package:techmart/features/check_out/funtions/helper_funtion.dart';
import 'package:techmart/features/check_out/models/payment_mode_model.dart';
import 'package:techmart/features/placeorder/bloc/order_bloc.dart';

class PlaceOrderButton extends StatelessWidget {
  const PlaceOrderButton({super.key, required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: CustemButton(
        hieght: 55,
        textSize: 22,
        label: "Place Order ",
        onpressed: () {
          final selectedId = context.read<SelectedAddressCubit>().state;
          final state = context.read<AdderssBloc>().state;

          final List<AddressModel?>? addressList =
              (state is AddressLoaded) ? state.addressList : null;

          if (addressList == null) {
            custemSnakbar(
              context: context,
              message: "Add Address First",
              color: Colors.red,
            );
            return;
          }
          final selectedModel = getSelectedAddress(
            selectedId,
            addressList.whereType<AddressModel>().toList(),
          );
          PaymentMode selectedPaymentMethod =
              context.read<SelectPaymentCubic>().state;
          List<ProductCartModel> listCart =
              (context.read<CartBloc>().state as CartLoaded).cartItems;
          if (selectedPaymentMethod == PaymentMode.cod) {
            log("selectedpaymentiscod");
            context.read<OrderBloc>().add(
              PlaceOrderCod(
                address: selectedModel,
                cartList: listCart,
                total: total,
                deliverycharge: "0",
              ),
            );
            return;
          }
          context.read<OrderBloc>().add(
            PlaceOnlineOrder(
              address: selectedModel,
              cartList: listCart,
              total: total,
              deliverycharge: "0",
            ),
          );
          log(toString(selectedPaymentMethod));
        },
      ),
    );
  }
}
