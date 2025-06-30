import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:techmart/features/authentication/bloc/auth_bloc.dart';

import 'package:techmart/firebase_options.dart';
import 'package:techmart/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  Gemini.init(apiKey: dotenv.env["GEMINI_API_KEY"]!);
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
            displaySmall: GoogleFonts.lato(
              fontSize: 45,
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
        // initialRoute: AppRoutes.home,
        // routes: {
        //   AppRoutes.splash: (context) => SplashScreen(),
        //   AppRoutes.welcome: (context) => WelcomeScreen(),
        //   AppRoutes.login: (context) => LoginScreen(),
        //   AppRoutes.signUp: (context) => SignUpScreen(),
        //   AppRoutes.privacyPolicy: (context) => PrivacyPolicyScreen(),
        //   AppRoutes.terms: (context) => TermsAndConditionsPage(),
        //   AppRoutes.home: (context) => Home(),
        //   AppRoutes.resetPassword: (context) => PasswordResetScreen(),
        //   AppRoutes.homeScreen: (context) => HomeScreen(),
        // },
      ),
    );
  }
}
