import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/coupen_add_buttom_widget.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/accounts/features/address/bloc/adderss_bloc.dart';
import 'package:techmart/features/accounts/features/address/models/address_model.dart';
import 'package:techmart/features/check_out/cubit/select_payment_cubic.dart';

import 'package:techmart/features/check_out/cubit/selected_address_cubit.dart';
import 'package:techmart/features/check_out/funtions/helper_funtion.dart';
import 'package:techmart/features/check_out/presentation/widgets/delevry_address.dart';
import 'package:techmart/features/check_out/presentation/widgets/payment_method_widget.dart';
import 'package:techmart/features/check_out/presentation/widgets/sddress_shimmer.dart';
import 'package:techmart/features/check_out/presentation/widgets/select_address_card.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custemAppbar(heading: "Checkout", context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
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
                return SizedBox();
              },
            ),
            const VerticalSpaceWisget(8),

            Divider(height: 32),

            PaymentMethodWIdget(
              paymentCubic: context.read<SelectPaymentCubic>(),
            ),

            Divider(height: 32),
            VerticalSpaceWisget(12),

            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
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
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 217, 255, 0),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
                HorizontalSpaceWisget(15),
                Expanded(
                  flex: 1,
                  child: CustemAddCoupoupenButton(
                    label: "Add",
                    onpressed: () {},
                    hieght: 50,
                  ),
                ),
              ],
            ),
            VerticalSpaceWisget(20),
            // Order Summary
            Text(
              "Order Summary",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            _summaryRow("Subtotal", "₹ 1,07,021"),
            _summaryRow("Discount", "-₹9,865"),
            _summaryRow("Shipping fee", "₹0"),
            const Divider(),
            _summaryRow("Total", "₹ 1,07,021.00", isBold: true),
            const SizedBox(height: 16),

            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: CustemButton(
          hieght: 60,
          Label: "Place Order ",
          onpressed: () {},
        ),
      ),
    );
  }

  Widget _summaryRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                isBold
                    ? GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    )
                    : GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.black45,
                      fontWeight: FontWeight.w200,
                    ),
          ),
          Text(
            value,
            style:
                isBold
                    ? GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    )
                    : GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
          ),
        ],
      ),
    );
  }
}
