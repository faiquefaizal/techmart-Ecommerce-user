import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:techmart/core/models/app_routes.dart';
import 'package:techmart/features/authentication/bloc/auth_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<AuthBlocBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is WelcomeState) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
          } else if (state is Authticated) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.home);
          } else if (state is UnAuthenticated) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.login);
          } else if (state is ErrorAuth) {
            // log(state.error);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Error:${state.error}")));
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Image.asset("assets/logo.png", height: 250),
                SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                LottieBuilder.asset("assets/splash_screen_loading.json"),
              ],
            ),
          );
        },
      ),
    );
  }
}
