import 'package:flutter/material.dart';
import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/core/widgets/form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(25, 70, 25, 30),
        // padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 70),
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
            ),

            Row(
              children: [
                Text("Forget your password?"),
                TextButton(
                  onPressed: () {},
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
            SizedBox(height: 15),

            CustemButton(Label: "Login", onpressed: () {}),
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
              Label: "Sign Up with Google",
              color: Colors.white,
              onpressed: () {},
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
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an Account?",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("SignUp");
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
    );
  }
}
