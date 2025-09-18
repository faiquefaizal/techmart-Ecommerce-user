import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/features/authentication/bloc/auth_bloc.dart';

void orderPlacedDialog(BuildContext context) {
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
                Lottie.asset(
                  "assets/Tick.json",
                  width: 90,
                  height: 90,
                  repeat: false,
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.green.shade100, // light green background
                //     shape: BoxShape.circle,
                //   ),
                //   padding: EdgeInsets.all(8),
                //   child: Icon(Icons.check, color: Colors.green, size: 40),
                // ),
                // SizedBox(height: 15),
                Text(
                  "Congratulations",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(height: 15),
                Text(
                  "Your order has been placed!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 15),
                CustemButton(
                  label: "Ok",
                  onpressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    // context.read<AuthBlocBloc>().add(Logout());
                  },
                  borderColor: Colors.black,
                  color: Colors.black,
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
  );
}
