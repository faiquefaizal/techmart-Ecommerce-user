import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/utils/text_util.dart/capitalizse_text.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/address/bloc/adderss_bloc.dart';
import 'package:techmart/features/address/cubit/current_address_cubit/current_address_cubic_cubit.dart';
import 'package:techmart/features/address/presentation/widgets/add_address_bottonsheet.dart';
import 'package:techmart/features/check_out/cubit/selected_address_cubit.dart';
import 'package:techmart/features/check_out/funtions/helper_funtion.dart';
import 'package:techmart/features/check_out/presentation/widgets/select_address_card.dart';

class AddressSelectPage extends StatelessWidget {
  const AddressSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custemAppbar(heading: "Address", context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: BlocBuilder<AdderssBloc, AdderssState>(
            builder: (context, state) {
              final cubicState = context.watch<SelectedAddressCubit>().state;

              if (state is AddressLoaded) {
                final String selected =
                    cubicState ?? getDefaultId(state.addressList);
                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,

                      itemCount: state.addressList.length,

                      itemBuilder: (context, index) {
                        final address = state.addressList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SelectAddressCard(
                            title: captilize(address!.fullName),
                            address: address.fulladdress,
                            isDefault: address.isDefault,
                            value: address.id!,
                            groupvalue: selected,
                            addresscubic: context.read<SelectedAddressCubit>(),
                          ),
                        );
                      },
                    ),
                    VerticalSpaceWisget(8),
                    CustemButton(
                      textcolor: Colors.black,
                      color: Colors.white,
                      hieght: 55,
                      label: "+ Add New Address",
                      textSize: 20,
                      fontWeight: FontWeight.w500,
                      borderColor: Colors.grey.shade200,
                      onpressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          isDismissible: true,
                          enableDrag: true,
                          builder: (context) {
                            return BlocProvider(
                              create: (context) => CurrentAddressCubicCubit(),
                              child: AddressBottomSheet(),
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: CustemButton(
          textSize: 22,
          label: "Apply",
          onpressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
