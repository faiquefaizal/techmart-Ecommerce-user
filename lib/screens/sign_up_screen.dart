import 'package:flutter/material.dart';
import 'package:techmart/core/widgets/form_field.dart';

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
  final TextEditingController GenderController = TextEditingController();
  final TextEditingController PhoneController = TextEditingController();
  // final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
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

              // CustemTextFIeld(label: , hintText: , controller: controller),
              // CustemTextFIeld(label: label, hintText: hintText, controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}
