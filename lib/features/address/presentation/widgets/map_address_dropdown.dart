import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/utils/validators.dart';

import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/holder_widget.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/address/bloc/adderss_bloc.dart';
import 'package:techmart/features/address/cubit/current_address_cubit/current_address_cubic_cubit.dart';
import 'package:techmart/features/address/models/address_model.dart';
import 'package:techmart/features/address/presentation/widgets/address_textfield.dart';
import 'package:techmart/features/address/presentation/widgets/map_address_card.dart';

class MapAddressDropdown extends StatefulWidget {
  const MapAddressDropdown({super.key});

  @override
  State<MapAddressDropdown> createState() => _MapAddressDropdownState();
}

class _MapAddressDropdownState extends State<MapAddressDropdown> {
  @override
  Widget build(BuildContext context) {
    final currentaddresCubic = context.read<CurrentAddressCubicCubit>();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(15),

      child: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          children: [
            HolderWIdget(),
            Text(
              "Deliver to ",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            MapAddressCard(),

            AddressTextFieldWidget(
              label: "Flat/House no./Building *",
              keyboardtype: TextInputType.streetAddress,
              validator: Validators.houseNo,
              autofocus: true,
              controller: currentaddresCubic.houseController,
            ),

            AddressTextFieldWidget(
              label: "Enter your full name *",
              keyboardtype: TextInputType.name,
              validator: Validators.name,
              controller: currentaddresCubic.fullNameController,
            ),
            AddressTextFieldWidget(
              label: "10-digit mobile number *",
              keyboardtype: TextInputType.phone,
              validator: Validators.phone,
              controller: currentaddresCubic.phoneController,
            ),
            VerticalSpaceWisget(10),
            CustemButton(
              hieght: 45,
              label: "Add address",
              onpressed: () {
                final newAddress = currentaddresCubic.toAddressModel();
                log(newAddress.toString());
                if (formKey.currentState!.validate()) {
                  // final state = context.read<CurrentAddressCubicCubit>().state;
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
                  log("hello");
                  context.read<AdderssBloc>().add(
                    AddAddressEvent(addressModel: newAddress),
                  );
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
