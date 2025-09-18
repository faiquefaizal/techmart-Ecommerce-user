import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:techmart/core/models/app_routes.dart';
import 'package:techmart/core/utils/validators.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/form_field.dart';
import 'package:techmart/core/widgets/loading_widget.dart';
import 'package:techmart/core/widgets/snakbar_widgert.dart';
import 'package:techmart/features/authentication/bloc/auth_bloc.dart';
import 'package:techmart/features/authentication/presentation/widgets/reset_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBlocBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is AuthBlocLoading) {
          Logger().w("state is AuthBlocLoading");
          showDialog(
            context: context,
            barrierColor: Colors.transparent,
            barrierDismissible: false,
            builder: (_) => CustomLoadingIndicator(),
          );
        }
        if (state is ErrorAuth) {
          if (Navigator.canPop(context)) Navigator.pop(context);
          custemSnakbar(
            context: context,
            message: state.error,
            color: Colors.red,
          );
        } else if (state is Authticated) {
          if (Navigator.canPop(context)) Navigator.pop(context);

          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(
              left: 25,
              top: 70,
              right: 25,
              bottom: MediaQuery.viewInsetsOf(context).bottom,
            ),

            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login to your account",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "It's great to see you again.",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 20),
                  CustemTextFIeld(
                    validator: Validators.email,
                    label: "Email",
                    hintText: "Enter your Email",
                    controller: emailController,
                  ),
                  SizedBox(height: 10),
                  CustemTextFIeld(
                    label: "Password",
                    hintText: "Enter your Password",
                    controller: passwordController,
                    password: true,
                    validator: Validators.password,
                  ),

                  FittedBox(
                    child: Row(
                      children: [Text("Forget your password?"), ResetButton()],
                    ),
                  ),
                  SizedBox(height: 15),

                  CustemButton(
                    label: "Login",
                    onpressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBlocBloc>().add(
                          LogininEvent(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(child: Divider(indent: 10, endIndent: 10)),
                      Text("Or"),
                      Expanded(child: Divider(indent: 10, endIndent: 10)),
                    ],
                  ),
                  SizedBox(height: 40),
                  CustemButton(
                    label: "Sign Up with Google",
                    color: Colors.white,
                    onpressed: () {
                      context.read<AuthBlocBloc>().add(GoogleSignInEvent());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/Google_Icons-09-512.webp"),
                        Text(
                          "Sign Up with Google",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40), // Replace Spacer()

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an Account?",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.signUp);
                        },
                        child: Text(
                          "Join",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
