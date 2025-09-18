import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/utils/validators.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/form_field.dart';
import 'package:techmart/features/address/bloc/adderss_bloc.dart';
import 'package:techmart/features/address/cubit/current_address_cubit/current_address_cubic_cubit.dart';
import 'package:techmart/features/address/models/address_model.dart';

// UpdatedBottomSheet(BuildContext context) {
//   final currentAddressCubic = context.read<CurrentAddressCubicCubit>();
//   final formKey = GlobalKey<FormState>();

//   return PopScope(
//     canPop: false,
//     onPopInvokedWithResult: (didPop, result) async {
//       if (didPop) return; // If already popped, do nothing
//       final currentFocus = FocusScope.of(context);
//       if (currentFocus.hasFocus) {
//         log("reached");
//         currentFocus.unfocus(); // Close the keyboard
//         return; // Prevent pop
//       }
//       // Allow pop if no focus
//       Navigator.of(context).pop();
//     },
//     child:
//   );
// }

class UpdatedBottomSheet extends StatelessWidget {
  const UpdatedBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    final currentAddressCubic = context.watch<CurrentAddressCubicCubit>();
    final formKey = GlobalKey<FormState>();
    return Container(
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
              Text("Address", style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 8),
              Divider(),
              SizedBox(height: 8),

              NewCustemFormField(
                label: "Full Name",
                autofocus: true,
                // intialValue: state.fullName,
                hintText: "Enter full name",
                controller: currentAddressCubic.fullNameController,
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
                controller: currentAddressCubic.phoneController,

                validator: Validators.phone,
              ),

              Row(
                children: [
                  Expanded(
                    child: NewCustemFormField(
                      label: "State",
                      controller: currentAddressCubic.stateController,
                      hintText: "Enter state",

                      validator: Validators.state,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: NewCustemFormField(
                      label: "Pin Code",
                      hintText: "Enter pin",
                      controller: currentAddressCubic.pinController,
                      keyboardType: TextInputType.number,

                      validator: Validators.pinCode,
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: NewCustemFormField(
                      label: "City",
                      controller: currentAddressCubic.cityController,
                      hintText: "Enter city",

                      validator: Validators.city,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: NewCustemFormField(
                      label: "Area",
                      controller: currentAddressCubic.areaController,
                      hintText: "Area/Landmark",

                      validator: Validators.area,
                    ),
                  ),
                ],
              ),

              NewCustemFormField(
                label: "House No.",
                hintText: "Enter house/flat number",
                controller: currentAddressCubic.houseController,
                validator: Validators.houseNo,
              ),

              Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.black,
                        value: currentAddressCubic.isDefault,
                        onChanged:
                            (value) => context
                                .read<CurrentAddressCubicCubit>()
                                .toggleIsDefault(value ?? false),
                      ),

                      Text("Make this your default address"),
                    ],
                  ),
                  CustemButton(
                    label: "Apply",
                    onpressed: () {
                      if (formKey.currentState!.validate()) {
                        final newAddress = currentAddressCubic.toAddressModel();
                        log(newAddress.fullName);
                        log(newAddress.toString());
                        log(newAddress.id.toString());
                        context.read<AdderssBloc>().add(
                          EditAddressEvent(updatedAddress: newAddress),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
