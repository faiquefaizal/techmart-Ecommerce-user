import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/features/authentication/bloc/auth_bloc.dart';

CustemDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder:
        (context) => Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.red.shade100,
                  radius: 40,
                  child: Icon(Icons.error_outline, color: Colors.red, size: 50),
                ),
                SizedBox(height: 15),
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
                  Label: "Yes",
                  onpressed: () {
                    context.read<AuthBlocBloc>().add(Logout());
                    Navigator.pop(context);
                    // context.read<AuthBlocBloc>().add(Logout());
                  },
                  color: Colors.red,
                ),
                SizedBox(height: 15),
                CustemButton(
                  Label: "No",
                  onpressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                  textcolor: Colors.black,
                ),
              ],
            ),
          ),
        ),
  );
}
