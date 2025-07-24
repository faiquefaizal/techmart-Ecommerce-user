import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/core/widgets/custem_alrert_dialog.dart';
import 'package:techmart/features/accounts/features/address/bloc/adderss_bloc.dart';
import 'package:techmart/features/accounts/features/address/cubit/current_address_cubit/current_address_cubic_cubit.dart';
import 'package:techmart/features/accounts/features/address/models/address_model.dart';
import 'package:techmart/features/accounts/features/address/presentation/widgets/updated_address_botton_sheet.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key, required this.address});

  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.location_on_outlined, size: 40, color: Colors.black),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        address.fullName,
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          height: 1,
                        ),
                      ),
                      if (address.isDefault) ...[
                        SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4),
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
                      ],
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
                                        child: UpdatedBottomSheet(context),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          // Delete button
                          IconButton(
                            icon: Icon(Icons.delete, size: 20),
                            color: Colors.red,
                            onPressed: () {
                              showDeleteConfirmationDialog(
                                context,
                                () => context.read<AdderssBloc>().add(
                                  DeleteAddressEvent(id: address.id!),
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
  }
}
