import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/form_field.dart';
import 'package:techmart/core/widgets/snakbar_widgert.dart';
import 'package:techmart/features/authentication/service/Auth_service.dart';

class PasswordResetScreen extends StatelessWidget {
  final AuthService authService = AuthService();
  final _formState = GlobalKey<FormState>();
  PasswordResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Forget Password",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(height: 15),
            Text(
              "Enter your email for verification process,",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 5),
            Text(
              "We will send a verifcation mail to your email.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            Form(
              key: _formState,
              child: CustemTextFIeld(
                label: "Email",
                hintText: "Enter yout Email",
                controller: emailcontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email cannot be empty";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            CustemButton(
              label: "Send Code",
              onpressed: () {
                if (_formState.currentState!.validate()) {
                  // if(email.isEmpty){

                  // }
                  try {
                    // if (email.isEmpty) {
                    //   return custemSnakbar(context, "Enter email", Colors.red);
                    // }
                    authService.passWordReset(emailcontroller.text.trim());

                    custemSnakbar(
                      context: context,
                      message: "Verification link send to your Mail",
                      color: Colors.red,
                    );
                    // showDialog(
                    //   context: context,
                    //   builder: (_) {
                    //     return AlertDialog(
                    //       title: Text("Verification link send to your Mail"),
                    //     );
                    //   },
                    // );
                  } on FirebaseAuthException catch (e) {
                    custemSnakbar(
                      context: context,
                      message: e.message.toString(),
                      color: Colors.red,
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
