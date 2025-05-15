import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/form_field.dart';
import 'package:techmart/features/authentication/service/Auth_service.dart';
import 'package:techmart/features/authentication/service/model/user_model.dart';

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
  String? selectedValue;
  String? selectedcode = "+91";
  // final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
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
                ),
                CustemTextFIeld(
                  label: "Email",
                  hintText: "Enter your Email",
                  controller: emailController,
                ),
                CustemTextFIeld(
                  label: "Password",
                  hintText: "Enter your password",
                  controller: passwordController,
                ),
                CustemTextFIeld(
                  label: "Confirm Password",
                  hintText: "Enter your password again",
                  controller: passwordController,
                ),
                DatePickerFormField(
                  controller: dobController,
                  label: "Date of Birth",
                  firstDate: DateTime(1960),
                  lastDate: DateTime(2007),
                ),
                CustemDropDown(
                  label: "Gender",
                  items: [
                    DropdownMenuItem(value: "Male", child: Text("Male")),
                    DropdownMenuItem(value: "Female", child: Text("Female")),
                    DropdownMenuItem(value: "other", child: Text("Other")),
                  ],
                  seletedValue: selectedValue,
                ),
                PhoneNumberField(
                  hintText: "9800000000",
                  controller: phoneController,
                  selectedCountryCode: selectedcode,
                  label: "Phone",
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
                                ).pushNamed("termsandcondition");
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
                                ).pushNamed("privacyPolicy");
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
    );
  }
}
