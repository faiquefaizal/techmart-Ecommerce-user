import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/core/models/app_routes.dart';
import 'package:techmart/features/authentication/bloc/auth_bloc.dart';

import 'package:techmart/features/authentication/screens/login_screen.dart';
import 'package:techmart/features/authentication/screens/password_reset_screen.dart';
import 'package:techmart/features/authentication/screens/privacy_policy.dart';
import 'package:techmart/features/authentication/screens/sign_up_screen.dart';
import 'package:techmart/features/authentication/screens/spash_screen.dart';
import 'package:techmart/features/authentication/screens/terms_and_condition.dart';
import 'package:techmart/features/authentication/screens/welcome_screen.dart';
import 'package:techmart/firebase_options.dart';
import 'package:techmart/screens/home.dart';
import 'package:techmart/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBlocBloc(),
      child: MaterialApp(
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
            headlineMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w200,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.pressed)) {
                  return Colors.grey;
                }
                return Colors.black; // Default color
              }),
            ),
          ),
        ),
        home: Home(),
        // initialRoute: AppRoutes.login,
        routes: {
          AppRoutes.splash: (context) => SplashScreen(),
          AppRoutes.welcome: (context) => WelcomeScreen(),
          AppRoutes.login: (context) => LoginScreen(),
          AppRoutes.signUp: (context) => SignUpScreen(),
          AppRoutes.privacyPolicy: (context) => PrivacyPolicyScreen(),
          AppRoutes.terms: (context) => TermsAndConditionsPage(),
          AppRoutes.home: (context) => Home(),
          AppRoutes.resetPassword: (context) => PasswordResetScreen(),
          AppRoutes.homeScreen: (context) => UserHomepage(),
        },
      ),
    );
  }
}
