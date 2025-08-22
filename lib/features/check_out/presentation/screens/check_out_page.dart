import 'dart:developer';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/core/widgets/animated_price_widget.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/coupen_add_buttom_widget.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/core/widgets/snakbar_widgert.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/address/bloc/adderss_bloc.dart';
import 'package:techmart/features/address/cubit/current_address_cubit/current_address_cubic_cubit.dart';
import 'package:techmart/features/address/models/address_model.dart';
import 'package:techmart/features/cart/bloc/cart_bloc.dart';
import 'package:techmart/features/cart/model/product_cart_model.dart';
import 'package:techmart/features/check_out/cubit/select_payment_cubic.dart';

import 'package:techmart/features/check_out/cubit/selected_address_cubit.dart';
import 'package:techmart/features/check_out/funtions/helper_funtion.dart';
import 'package:techmart/features/check_out/models/payment_mode_model.dart';
import 'package:techmart/features/check_out/presentation/widgets/add_address_widget.dart';
import 'package:techmart/features/check_out/presentation/widgets/coupen_widget.dart';
import 'package:techmart/features/check_out/presentation/widgets/delevry_address.dart';
import 'package:techmart/features/check_out/presentation/widgets/payment_method_widget.dart';
import 'package:techmart/features/check_out/presentation/widgets/sddress_shimmer.dart';
import 'package:techmart/features/check_out/presentation/widgets/sumary_row_widget.dart';
import 'package:techmart/features/coupen/cubit/coupen_cubit.dart';
import 'package:techmart/features/placeorder/bloc/order_bloc.dart';
import 'package:techmart/features/payments/service/payment_service.dart';
import 'package:techmart/features/placeorder/presentation/widget/order_placed_dialog.dart';

class CheckoutPage extends StatelessWidget {
  Map<String, double> sellerByMap;
  int total;

  CheckoutPage({super.key, required this.total, required this.sellerByMap});
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custemAppbar(heading: "Checkout", context: context),
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is LoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (context) => const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  ),
            );
          }
          if (state is OrderPlacedSuccessfully) {
            orderPlacedDialog(context);
            context.read<CartBloc>().add(FetchCart());
          }
          if (state is Errorstate) {
            Navigator.pop(context);
            custemSnakbar(
              context: context,
              message: state.message,
              color: Colors.red,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          child: ListView(
            children: [
              Divider(),
              const VerticalSpaceWisget(8),
              BlocBuilder<AdderssBloc, AdderssState>(
                builder: (context, state) {
                  if (state is AddressLoading) {
                    return AddressShimmer();
                  }

                  if (state is AddressLoaded) {
                    final selectedId =
                        context.watch<SelectedAddressCubit>().state;
                    final selectedModel = getSelectedAddress(
                      selectedId,
                      state.addressList.whereType<AddressModel>().toList(),
                    );

                    return AddressDelivery(
                      selectCubic: context.read<SelectedAddressCubit>(),
                      title: selectedModel.fullName,
                      address: selectedModel.fulladdress,
                    );
                  }
                  return AddAddressWidget();
                },
              ),
              const VerticalSpaceWisget(8),

              Divider(height: 32),

              PaymentMethodWIdget(
                paymentCubic: context.read<SelectPaymentCubic>(),
              ),

              Divider(height: 32),
              const VerticalSpaceWisget(10),

              // Order Summary
              Text(
                "Order Summary",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const VerticalSpaceWisget(8),
              BlocBuilder<CoupenCubit, CoupenState>(
                builder: (context, state) {
                  final discount =
                      (state is SuccessState) ? state.discount as int : 0;
                  int totalAmout = total - discount;
                  int shippingCharge = (totalAmout > 2000) ? 0 : 200;
                  return Column(
                    children: [
                      summaryRow(
                        "Subtotal",
                        wisget: AnimatedPriceWidget(total: total),
                      ),
                      summaryRow("Discount", value: discount.toString()),
                      summaryRow(
                        "Shipping fee",
                        value: shippingCharge.toString(),
                      ),
                      const Divider(),
                      summaryRow(
                        "Total",
                        wisget: AnimatedPriceWidget(total: totalAmout),
                        isBold: true,
                      ),
                      VerticalSpaceWisget(10),
                      CoupenWidget(
                        formkey: _formState,
                        total: total,
                        sellerList: sellerByMap,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
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
      ),
    );
  }
}
