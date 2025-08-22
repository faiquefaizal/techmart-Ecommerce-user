import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/models/app_routes.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/form_field.dart';
import 'package:techmart/core/widgets/loading_widget.dart';
import 'package:techmart/core/widgets/snakbar_widgert.dart';
import 'package:techmart/features/authentication/bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBlocBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is ErrorAuth) {
          if (Navigator.canPop(context)) Navigator.pop(context);
          custemSnakbar(
            context: context,
            message: state.error,
            color: Colors.red,
          );
          // ScaffoldMessenger.of(
          //   context,
          // ).showSnackBar(SnackBar(content: Text(state.error)));
        } else if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }

        if (state is AuthBlocLoading) {
          showDialog(
            context: context,
            builder: (_) => CustomLoadingIndicator(label: "Signing In"),
          );
          log("hello");
        } else if (state is Authticated) {
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
            // padding: EdgeInsets.fromLTRB(25, 70, 25, 30),
            // padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 70),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email cannot be empty";
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password cannot be empty";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),

                  FittedBox(
                    child: Row(
                      children: [
                        Text("Forget your password?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.resetPassword,
                            );
                          },
                          child: Text(
                            "Reset your password",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
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
