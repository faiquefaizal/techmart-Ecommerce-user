import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/form_field.dart';
import 'package:techmart/features/accounts/features/address/bloc/adderss_bloc.dart';
import 'package:techmart/features/accounts/features/address/cubit/address_cubit.dart';
import 'package:techmart/features/accounts/features/address/cubit/current_address_cubit/current_address_cubic_cubit.dart';
import 'package:techmart/features/accounts/features/address/models/address_model.dart';

addressBottomSheet(BuildContext context) {
  final formKey = GlobalKey<FormState>();

  return BlocBuilder<CurrentAddressCubicCubit, CurrentAddressCubicState>(
    builder: (context, state) {
      log(
        'BlocBuilder rebuilt with state: fullName=${state.fullName}, isDefault=${state.isDefault} ${state.area}',
      );
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
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      height: 8,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
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
                    onChanged: (value) {
                      context.read<CurrentAddressCubicCubit>().updateFullName(
                        value,
                      );
                    },
                    keyboardType: TextInputType.name,

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Full name is required";
                      }
                      if (value.trim().length < 3) {
                        return "Enter at least 3 characters";
                      }
                      return null;
                    },
                  ),
                  NewCustemFormField(
                    label: "Phone Number",
                    hintText: "Enter phone number",
                    keyboardType: TextInputType.phone,

                    onChanged: (value) {
                      context.read<CurrentAddressCubicCubit>().updatePhone(
                        value,
                      );
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Phone number is required";
                      }
                      if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
                        {
                          return "Enter a valid 10-digit phone number";
                        }
                      }
                      return null;
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: NewCustemFormField(
                          label: "State",
                          hintText: "Enter state",
                          onChanged: (value) {
                            context
                                .read<CurrentAddressCubicCubit>()
                                .updateState(value);
                          },
                          validator:
                              (value) =>
                                  value == null || value.trim().isEmpty
                                      ? 'State is required'
                                      : null,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: NewCustemFormField(
                          label: "Pin Code",
                          hintText: "Enter pin",
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            context.read<CurrentAddressCubicCubit>().updatePin(
                              value,
                            );
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Pin code is required";
                            }
                            if (!RegExp(r'^\d{6}$').hasMatch(value.trim())) {
                              {
                                return "Enter a valid 6-digit pin code";
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: NewCustemFormField(
                          label: "City",
                          hintText: "Enter city",
                          onChanged: (value) {
                            context.read<CurrentAddressCubicCubit>().updateCity(
                              value,
                            );
                          },
                          validator:
                              (value) =>
                                  value == null || value.trim().isEmpty
                                      ? 'City is required'
                                      : null,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: NewCustemFormField(
                          label: "Area",
                          hintText: "Area/Landmark",
                          onChanged: (value) {
                            context.read<CurrentAddressCubicCubit>().updateArea(
                              value,
                            );
                          },
                          validator:
                              (value) =>
                                  value == null || value.trim().isEmpty
                                      ? 'Area is required'
                                      : null,
                        ),
                      ),
                    ],
                  ),

                  NewCustemFormField(
                    label: "House No.",
                    hintText: "Enter house/flat number",
                    onChanged: (value) {
                      context.read<CurrentAddressCubicCubit>().updateHouse(
                        value,
                      );
                      log(value);
                    },
                    validator:
                        (value) =>
                            value == null || value.trim().isEmpty
                                ? 'House No. is required'
                                : null,
                  ),

                  Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            activeColor: Colors.black,
                            value: state.isDefault,
                            onChanged:
                                (value) => context
                                    .read<CurrentAddressCubicCubit>()
                                    .toggleIsDefault(value ?? false),
                          ),
                          Text("Make this your default address"),
                        ],
                      ),
                      CustemButton(
                        Label: "Apply",
                        onpressed: () {
                          if (formKey.currentState!.validate()) {
                            log("called");
                            final newAddress = AddressModel(
                              fullName: state.fullName.trim(),
                              phoneNumber: state.phoneNumber.trim(),
                              pinCode: state.pinCode.trim(),
                              state: state.state.trim(),
                              city: state.state.trim(),
                              houseNo: state.houseNo.trim(),
                              area: state.area.trim(),
                              isDefault: state.isDefault,
                            );
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
    },
  );
}
