import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/screens/login_screen.dart';
import 'package:techmart/screens/sign_up_screen.dart';
import 'package:techmart/screens/spash_screen.dart';
import 'package:techmart/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          displayLarge: GoogleFonts.lato(
            fontSize: 60,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
          displayMedium: GoogleFonts.lato(
            fontSize: 35,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
          headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.pressed)) {
                return Colors.grey; // Color when pressed
              }
              return Colors.black; // Default color
            }),
          ),
        ),
      ),
      // home: SplashScreen(),
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        "welcome": (context) => WelcomeScreen(),
        "loginscreen": (context) => LoginScreen(),
        "SignUp": (context) => SignUpScreen(),
      },
    );
  }
}
