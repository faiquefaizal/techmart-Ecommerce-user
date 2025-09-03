import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:logger/logger.dart';

import 'package:techmart/core/models/app_routes.dart';
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

import 'package:techmart/features/cart/presentation/screens/empty_cart_screen.dart';
import 'package:techmart/features/cart/presentation/widget/cart_product_widget.dart';
import 'package:techmart/features/chat_room/presention/screens/chat_screen.dart';
import 'package:techmart/features/check_out/presentation/screens/address_select_page.dart';
import 'package:techmart/features/check_out/presentation/screens/check_out_page.dart';
import 'package:techmart/features/notification/service/message_service.dart';
import 'package:techmart/features/orders/bloc/order_bloc.dart';
import 'package:techmart/features/orders/service/order_service.dart';
import 'package:techmart/features/placeorder/bloc/order_bloc.dart'
    hide FetchOrders;
import 'package:techmart/features/placeorder/service/place_order_service.dart';
import 'package:techmart/features/payments/const/payment.dart';
import 'package:techmart/features/return_request/presentation/screen/return_screen.dart';
import 'package:techmart/features/track_order/presentation/screens/order_details_screen.dart';
import 'package:techmart/features/wishlist_page/presentation/screens/empty_wishlist_screen.dart';
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
        BlocProvider(create: (context) => AuthBlocBloc()),
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
