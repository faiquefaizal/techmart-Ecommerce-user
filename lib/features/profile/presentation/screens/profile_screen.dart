import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/core/widgets/form_field.dart';
import 'package:techmart/features/authentication/model/user_model.dart';
import 'package:techmart/features/profile/cubit/userdetails_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModel?>(
      builder: (context, user) {
        if (user == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final formKey = GlobalKey<FormState>();
        final nameController = TextEditingController(text: user.name);
        final emailController = TextEditingController(text: user.email);
        final phoneController = TextEditingController(text: user.phone);

        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: custemAppbar(heading: "My Details", context: context),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustemTextFIeld(
                      label: "Full Name",
                      hintText: "Enter your Name",
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustemTextFIeld(
                      label: "Email Address",
                      hintText: "Enter your Email",
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Email is required";
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustemTextFIeld(
                      label: "Phone Number",
                      hintText: "Enter your Phone Number",
                      controller: phoneController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Phone number is required";
                        }
                        if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
                          return "Enter a valid phone number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    CustemButton(
                      label: "Submit",
                      onpressed: () {
                        if (formKey.currentState!.validate()) {
                          log(user.uid);
                          final updatedUser = user.copyWith(
                            uid: user.uid,
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                          log(updatedUser.toString());
                          context.read<UserCubit>().updateUser(updatedUser);
                          Navigator.of(context).pop();
                        }
                      },
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
}
