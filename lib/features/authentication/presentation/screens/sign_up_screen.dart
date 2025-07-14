import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/models/app_routes.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/form_field.dart';
import 'package:techmart/core/widgets/snakbar_widgert.dart';
import 'package:techmart/features/authentication/bloc/auth_bloc.dart';
import 'package:techmart/core/widgets/loading_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController conformPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedValue;
  String? selectedcode = "+91";
  // final TextEditingController nameController = TextEditingController();
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
        } else if (state is AuthBlocLoading) {
          CustomLoadingIndicator(label: "Registering User.....");
        } else if (state is Authticated) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create an Account",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Let's create your account.",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 10),
                    CustemTextFIeld(
                      label: "Full Name",
                      hintText: "Enter your Name",
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          if (value == null || value.trim().isEmpty) {
                            return "Name is required";
                          }
                          return null;
                        }
                      },
                    ),
                    CustemTextFIeld(
                      label: "Email",
                      hintText: "Enter your Email",
                      controller: emailController,
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
                    CustemTextFIeld(
                      label: "Password",
                      hintText: "Enter your password",
                      controller: passwordController,
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
                    CustemTextFIeld(
                      label: "Confirm Password",
                      hintText: "Enter your password again",
                      controller: conformPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please confirm your password";
                        } else if (value != passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                    DatePickerFormField(
                      controller: dobController,
                      label: "Date of Birth",
                      firstDate: DateTime(1960),
                      lastDate: DateTime(2007),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your date of birth';
                        }
                        return null;
                      },
                    ),
                    CustemDropDown(
                      label: "Gender",
                      items: [
                        DropdownMenuItem(value: "Male", child: Text("Male")),
                        DropdownMenuItem(
                          value: "Female",
                          child: Text("Female"),
                        ),
                        DropdownMenuItem(value: "other", child: Text("Other")),
                      ],
                      seletedValue: selectedValue,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return "Please select gender";
                      //   }
                      //   return null;
                      // },
                    ),
                    PhoneNumberField(
                      hintText: "9800000000",
                      controller: phoneController,
                      selectedCountryCode: selectedcode,
                      label: "Phone",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Phone number is required";
                        } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                          return "Enter a valid 10-digit phone number";
                        }
                        return null;
                      },
                      onCountryCodeChanged:
                          (selected) => setState(() {
                            selectedcode = selected;
                          }),
                    ),
                    SizedBox(height: 15),
                    RichText(
                      // selectionColor: Colors.black,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "By signing up you agree to our ",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: "Terms & conditons ",

                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(
                                      context,
                                    ).pushNamed(AppRoutes.terms);
                                  },
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                            text: " and ",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: "Privacy Policy",
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(
                                      context,
                                    ).pushNamed(AppRoutes.privacyPolicy);
                                  },
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    CustemButton(
                      Label: "Create an Account",
                      onpressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBlocBloc>().add(
                            Register(
                              name: nameController.text,
                              password: passwordController.text,
                              dob: dobController.text,
                              email: emailController.text,
                              gender: selectedValue,
                              phone: phoneController.text,
                            ),
                          );
                        }
                        // AuthService.registerUser(
                        //   name: nameController.text,
                        //   passord: passwordController.text,
                        //   dob: dobController.text,
                        //   email: emailController.text,
                        //   gender: genderController.text,
                        //   phone: phoneController.text,
                        // );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
