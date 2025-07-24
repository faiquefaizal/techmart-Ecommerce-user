import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:techmart/core/widgets/custem_alrert_dialog.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/features/accounts/features/address/bloc/adderss_bloc.dart';
import 'package:techmart/features/accounts/features/address/cubit/current_address_cubit/current_address_cubic_cubit.dart';
import 'package:techmart/features/accounts/features/address/models/address_model.dart';

import 'package:techmart/features/accounts/features/address/presentation/widgets/add_address_bottonsheet.dart';
import 'package:techmart/features/accounts/features/address/presentation/widgets/updated_address_botton_sheet.dart';
import 'package:techmart/features/accounts/presentation/screens/loading_address.dart';
import 'package:techmart/features/accounts/presentation/widgets/add_address_button.dart';
import 'package:techmart/features/accounts/presentation/widgets/address_card.dart';
import 'package:techmart/features/accounts/service/address_service.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custemAppbar(heading: "Address", context: context),
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Save Address",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            BlocConsumer<AdderssBloc, AdderssState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is AdderssInitial || state is AddressLoading) {
                  return AdderssWisgetBuilder();
                }
                if (state is EmptyAddress) {
                  return Center(child: Text("Address is  Empty Add First "));
                }
                if (state is AddressLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.addressList.length,
                      itemBuilder: (context, index) {
                        final address = state.addressList[index];
                        return AddressCard(address: address!);
                      },
                    ),
                  );
                }
                return Text("No state");
              },
            ),

            InkWell(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  isDismissible: true,
                  enableDrag: true,
                  builder: (context) {
                    return Builder(
                      builder: (context) {
                        return BlocProvider(
                          create: (_) => CurrentAddressCubicCubit(),
                          child: addressBottomSheet(context),
                        );
                      },
                    );
                  },
                );
              },
              child: AddAddressButton(),
            ),
          ],
        ),
      ),
    );
  }
}
