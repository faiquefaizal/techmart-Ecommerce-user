import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/features/authentication/bloc/auth_bloc.dart';
import 'package:techmart/features/check_out/models/payment_mode_model.dart';

logOutDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      try {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  "assets/logout_alert.json",
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,
                ),

                // SizedBox(height: 15),
                Text(
                  "Log out",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(height: 15),
                Text(
                  "Are you sure you want to logout?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 15),
                CustemButton(
                  label: "Yes",
                  onpressed: () {
                    context.read<AuthBlocBloc>().add(Logout());
                    Navigator.pop(context);
                    // context.read<AuthBlocBloc>().add(Logout());
                  },
                  borderColor: Colors.red,
                  color: Colors.red,
                ),
                SizedBox(height: 15),
                CustemButton(
                  label: "No",
                  onpressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                  textcolor: Colors.black,
                ),
              ],
            ),
          ),
        );
      } catch (e, stacktrace) {
        log(e.toString());
        rethrow;
      }
    },
  );
}
