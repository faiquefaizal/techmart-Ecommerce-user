import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/utils/validators.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/form_field.dart';
import 'package:techmart/core/widgets/holder_widget.dart';
import 'package:techmart/features/address/bloc/adderss_bloc.dart';
import 'package:techmart/features/address/cubit/address_cubit.dart';
import 'package:techmart/features/address/cubit/current_address_cubit/current_address_cubic_cubit.dart';
import 'package:techmart/features/address/cubit/current_location_cubit.dart';
import 'package:techmart/features/address/models/address_model.dart';
import 'package:techmart/features/address/presentation/widgets/current_location_widget.dart';

class AddressBottomSheet extends StatefulWidget {
  const AddressBottomSheet({super.key});

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final currentAddress = context.read<CurrentAddressCubicCubit>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        log('onPopInvokedWithResult: didPop=$didPop, result=$result');
        if (didPop) {
          log('Already popped, exiting');
          return;
        }
        final currentFocus = FocusScope.of(context);
        log(
          'Focus check: hasFocus=${currentFocus.hasFocus}, primaryFocus=${FocusManager.instance.primaryFocus}',
        );
        if (currentFocus.hasFocus ||
            FocusManager.instance.primaryFocus != null) {
          log('Attempting to dismiss keyboard');
          FocusManager.instance.primaryFocus?.unfocus();
          await SystemChannels.textInput.invokeMethod('TextInput.hide');
          await Future.delayed(const Duration(milliseconds: 200));
          log('Keyboard dismissed');
          return; // Prevent pop
        }

        log('No focus, allowing pop');
        Navigator.of(context).pop(null);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(
          15,
          5,
          16,
          MediaQuery.of(context).viewInsets.bottom,
        ),

        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HolderWIdget(),
                Text(
                  "Address",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 8),
                Divider(),
                SizedBox(height: 8),

                NewCustemFormField(
                  label: "Full Name",
                  autofocus: true,
                  hintText: "Enter full name",
                  controller: currentAddress.fullNameController,
                  // onChanged: (value) {
                  //   context.read<CurrentAddressCubicCubit>().updateFullName(
                  //     value,
                  //   );
                  // },
                  keyboardType: TextInputType.name,

                  validator: Validators.name,
                ),
                NewCustemFormField(
                  label: "Phone Number",
                  hintText: "Enter phone number",
                  keyboardType: TextInputType.phone,
                  controller: currentAddress.phoneController,
                  // onChanged: (value) {
                  //   context.read<CurrentAddressCubicCubit>().updatePhone(value);
                  // },
                  validator: Validators.phone,
                ),

                Row(
                  children: [
                    Expanded(
                      child: NewCustemFormField(
                        label: "State",
                        controller: currentAddress.stateController,
                        // intialValue: currentAddress.state,
                        hintText: "Enter state",

                        // onChanged: (value) {
                        //   context.read<CurrentAddressCubicCubit>().updateState(
                        //     value,
                        //   );
                        // },
                        validator: Validators.state,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: BlocProvider(
                        create:
                            (context) => CurrentLocationCubit(
                              context.read<CurrentAddressCubicCubit>(),
                            ),
                        child: GetLocationWidget(),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: NewCustemFormField(
                        label: "Pin Code",
                        hintText: "Enter pin",
                        controller: currentAddress.pinController,
                        keyboardType: TextInputType.number,
                        // onChanged: (value) {
                        //   context.read<CurrentAddressCubicCubit>().updatePin(
                        //     value,
                        //   );
                        // },
                        validator: Validators.pinCode,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: NewCustemFormField(
                        label: "City",
                        hintText: "Enter city",
                        controller: currentAddress.cityController,
                        // onChanged: (value) {
                        //   context.read<CurrentAddressCubicCubit>().updateCity(
                        //     value,
                        //   );
                        // },
                        validator: Validators.city,
                      ),
                    ),
                  ],
                ),
                NewCustemFormField(
                  label: "Area",
                  hintText: "Area/Landmark",
                  controller: currentAddress.areaController,
                  // onChanged: (value) {
                  //   context.read<CurrentAddressCubicCubit>().updateArea(value);
                  // },
                  validator: Validators.area,
                ),
                NewCustemFormField(
                  label: "House No.",
                  hintText: "Enter house/flat number",
                  controller: currentAddress.houseController,
                  // onChanged: (value) {
                  //   context.read<CurrentAddressCubicCubit>().updateHouse(value);
                  //   log(value);
                  // },
                  validator: Validators.houseNo,
                ),

                Column(
                  children: [
                    Row(
                      children: [
                        BlocBuilder<
                          CurrentAddressCubicCubit,
                          CurrentAddressCubicState
                        >(
                          builder: (context, state) {
                            return Checkbox(
                              activeColor: Colors.black,
                              value: state.isDefault,
                              onChanged:
                                  (value) => context
                                      .read<CurrentAddressCubicCubit>()
                                      .toggleIsDefault(value ?? false),
                            );
                          },
                        ),
                        Text("Make this your default address"),
                      ],
                    ),
                    CustemButton(
                      label: "Apply",
                      onpressed: () {
                        if (formKey.currentState!.validate()) {
                          log("called");
                          final newAddress = currentAddress.toAddressModel();
                          // final state =
                          //     context.read<CurrentAddressCubicCubit>().state;
                          // final newAddress = AddressModel(
                          //   fullName: state.fullName.trim(),
                          //   phoneNumber: state.phoneNumber.trim(),
                          //   pinCode: state.pinCode.trim(),
                          //   state: state.state.trim(),
                          //   city: state.state.trim(),
                          //   houseNo: state.houseNo.trim(),
                          //   area: state.area.trim(),
                          //   isDefault: state.isDefault,
                          // );
                          log("${newAddress.fullName} dkjsafkl");

                          context.read<AdderssBloc>().add(
                            AddAddressEvent(addressModel: newAddress),
                          );

                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
