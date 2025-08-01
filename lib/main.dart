import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/core/models/app_routes.dart';
import 'package:techmart/core/theme/app_theme.dart';
import 'package:techmart/features/accounts/features/address/bloc/adderss_bloc.dart';
import 'package:techmart/features/accounts/features/address/cubit/address_cubit.dart';
import 'package:techmart/features/accounts/presentation/screens/account_screen.dart';

import 'package:techmart/features/authentication/bloc/auth_bloc.dart';
import 'package:techmart/features/authentication/presentation/spash_screen.dart';
import 'package:techmart/features/authentication/presentation/screens/login_screen.dart';
import 'package:techmart/features/authentication/presentation/screens/password_reset_screen.dart';
import 'package:techmart/features/authentication/presentation/screens/privacy_policy.dart';
import 'package:techmart/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:techmart/features/authentication/presentation/screens/terms_and_condition.dart';
import 'package:techmart/features/authentication/presentation/screens/welcome_screen.dart';
import 'package:techmart/features/cart/bloc/cart_bloc.dart';

import 'package:techmart/features/cart/presentation/screens/empty_cart_screen.dart';
import 'package:techmart/features/cart/presentation/widget/cart_product_widget.dart';
import 'package:techmart/features/check_out/presentation/screens/address_select_page.dart';
import 'package:techmart/features/check_out/presentation/screens/check_out_page.dart';
import 'package:techmart/features/wishlist_page/presentation/screens/empty_wishlist_screen.dart';
import 'package:techmart/features/home_page/presentation/screens/home_screen.dart';
import 'package:techmart/features/wishlist_page/cubit/wishlist_cubit.dart';

import 'package:techmart/firebase_options.dart';
import 'package:techmart/screens/home.dart';
import 'package:techmart/features/check_out/presentation/widgets/select_address_card.dart';

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
        BlocProvider(create: (context) => CartBloc()..add(FetchCart())),
        BlocProvider(create: (context) => AdderssBloc()..add(GetAllAddress())),
      ],
      child: MaterialApp(
        theme: appTheme,

        // home: CheckoutPage(),
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
          AppRoutes.SelectAddressPage: (context) => AddressSelectPage(),
        },
      ),
    );
  }
}
