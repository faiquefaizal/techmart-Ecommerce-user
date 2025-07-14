import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:techmart/core/widgets/custem_alrert_dialog.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/features/accounts/features/address/bloc/adderss_bloc.dart';
import 'package:techmart/features/accounts/features/address/cubit/current_address_cubit/current_address_cubic_cubit.dart';

import 'package:techmart/features/accounts/features/address/presentation/widgets/add_address_bottonsheet.dart';
import 'package:techmart/features/accounts/features/address/presentation/widgets/updated_address_botton_sheet.dart';
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
                  return CircularProgressIndicator();
                }
                if (state is EmptyAddress) {
                  return Text("empty");
                }
                if (state is AddressLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.addressList.length,
                      itemBuilder: (context, index) {
                        final address = state.addressList[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 40,
                                color: Colors.black,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          address!.fullName,
                                          style: GoogleFonts.lato(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            height: 1,
                                          ),
                                        ),
                                        if (address.isDefault)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: const Text(
                                              "DEFAULT",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w900,
                                                letterSpacing: 0.5,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        Row(
                                          children: [
                                            // Edit button
                                            IconButton(
                                              icon: Icon(Icons.edit, size: 20),
                                              color: Colors.grey,
                                              onPressed: () {
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  isDismissible: true,
                                                  enableDrag: true,
                                                  builder: (context) {
                                                    return Builder(
                                                      builder: (context) {
                                                        log(address.id!);
                                                        return BlocProvider(
                                                          create:
                                                              (_) =>
                                                                  CurrentAddressCubicCubit()
                                                                    ..intializeWithAddress(
                                                                      address,
                                                                    ),
                                                          child:
                                                              UpdatedBottomSheet(
                                                                context,
                                                              ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            // Delete button
                                            IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                size: 20,
                                              ),
                                              color: Colors.red,
                                              onPressed: () {
                                                showDeleteConfirmationDialog(
                                                  context,
                                                  () => context
                                                      .read<AdderssBloc>()
                                                      .add(
                                                        DeleteAddressEvent(
                                                          id: address.id!,
                                                        ),
                                                      ),
                                                  "Address Deleted",
                                                  Colors.red,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "${address.houseNo}, ${address.area}, ${address.city}, ${address.state} - ${address.pinCode}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Phone: +91 ${address.phoneNumber}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
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
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "+ Add New Address",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
