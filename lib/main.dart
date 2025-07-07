import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/core/models/app_routes.dart';

import 'package:techmart/features/authentication/bloc/auth_bloc.dart';
import 'package:techmart/features/authentication/presentation/spash_screen.dart';
import 'package:techmart/features/authentication/screens/login_screen.dart';
import 'package:techmart/features/authentication/screens/password_reset_screen.dart';
import 'package:techmart/features/authentication/screens/privacy_policy.dart';
import 'package:techmart/features/authentication/screens/sign_up_screen.dart';
import 'package:techmart/features/authentication/screens/terms_and_condition.dart';
import 'package:techmart/features/authentication/screens/welcome_screen.dart';
import 'package:techmart/features/cart/cubit/cart_cubit.dart';
import 'package:techmart/features/cart/presentation/screens/empty_cart_screen.dart';
import 'package:techmart/features/cart/presentation/widget/cart_product_widget.dart';
import 'package:techmart/features/home_page/presentation/screens/empty_wishlist_screen.dart';
import 'package:techmart/features/home_page/presentation/screens/home_screen.dart';
import 'package:techmart/features/wishlist_page/cubit/wishlist_cubit.dart';

import 'package:techmart/firebase_options.dart';
import 'package:techmart/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load();
  // Gemini.init(apiKey: dotenv.env["GEMINI_API_KEY"]!);
  Gemini.init(apiKey: "AIzaSyCNVTq0wcoRgoUS-p61F5FYvN2F8jQdVGQ");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBlocBloc()),
        BlocProvider(create: (context) => WishlistCubit()..fetchWisList()),
        BlocProvider(create: (context) => CartCubit()..fetchAllCart()),
      ],
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
            headlineLarge: GoogleFonts.lato(
              fontSize: 35,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
            headlineSmall: GoogleFonts.lato(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              height: 1,
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
        // home: EmptyCartScreen(),
        initialRoute: AppRoutes.splash,
        routes: {
          AppRoutes.splash: (context) => SplashScreen(),
          AppRoutes.welcome: (context) => WelcomeScreen(),
          AppRoutes.login: (context) => LoginScreen(),
          AppRoutes.signUp: (context) => SignUpScreen(),
          AppRoutes.privacyPolicy: (context) => PrivacyPolicyScreen(),
          AppRoutes.terms: (context) => TermsAndConditionsPage(),
          AppRoutes.home: (context) => Home(),
          AppRoutes.resetPassword: (context) => PasswordResetScreen(),
          AppRoutes.homeScreen: (context) => HomeScreen(),
        },
      ),
    );
  }
}
