import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:techmart/core/models/app_routes.dart';
import 'package:techmart/core/navigation/cubit/navigation_cubit.dart';
import 'package:techmart/core/theme/app_theme.dart';
import 'package:techmart/features/address/bloc/adderss_bloc.dart';

import 'package:techmart/features/authentication/bloc/auth_bloc.dart';
import 'package:techmart/features/authentication/presentation/spash_screen.dart';
import 'package:techmart/features/authentication/presentation/screens/login_screen.dart';
import 'package:techmart/features/authentication/presentation/screens/password_reset_screen.dart';
import 'package:techmart/features/authentication/presentation/screens/privacy_policy.dart';
import 'package:techmart/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:techmart/features/authentication/presentation/screens/terms_and_condition.dart';
import 'package:techmart/features/authentication/presentation/screens/welcome_screen.dart';
import 'package:techmart/features/cart/bloc/cart_bloc.dart';

import 'package:techmart/features/check_out/presentation/screens/address_select_page.dart';

import 'package:techmart/features/home_page/cubit/catogory_cubic_cubit.dart';
import 'package:techmart/features/notification/service/message_service.dart';
import 'package:techmart/features/orders/bloc/order_bloc.dart';
import 'package:techmart/features/orders/service/order_service.dart';
import 'package:techmart/features/placeorder/bloc/order_bloc.dart'
    hide FetchOrders;
import 'package:techmart/features/placeorder/service/place_order_service.dart';
import 'package:techmart/features/payments/const/payment.dart';

import 'package:techmart/features/home_page/presentation/screens/sample.dart';
import 'package:techmart/features/wallet/presentation/screens/wallet_screen.dart';
import 'package:techmart/features/wishlist/cubit/wishlist_cubit.dart';

import 'package:techmart/firebase_options.dart';
import 'package:techmart/core/navigation/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  Gemini.init(apiKey: dotenv.env["GEMINI_API_KEY"]!);
  log(dotenv.env["GEMINI_API_KEY"]!);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await MessageService().initialiazeNotification();
  Stripe.publishableKey = publishableKey;
  // Logger().w("SecretKEy: $secretkey  ");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CatogoryCubicCubit()..fetchCatagories(),
        ),
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(
          create: (context) => AuthBlocBloc()..add(AuthCheckEvent()),
        ),
        BlocProvider(create: (context) => WishlistCubit()..fetchWisList()),
        BlocProvider(create: (context) => CartBloc()..add(FetchCart())),
        BlocProvider(create: (context) => AdderssBloc()..add(GetAllAddress())),
        BlocProvider(create: (context) => OrderBloc(PlaceOrderService())),
        BlocProvider(
          create:
              (context) => FetchOrderBloc(OrderService())..add(FetchOrders()),
        ),
      ],
      child: MaterialApp(
        theme: appTheme,
        // home: WalletScreen(),
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
