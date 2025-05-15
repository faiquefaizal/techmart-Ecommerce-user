import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/models/app_routes.dart';
import 'package:techmart/features/authentication/bloc/auth_bloc.dart';
import 'package:techmart/features/authentication/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<AuthBlocBloc>().add(AuthCheckEvent());

    super.initState();
  }

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
                CircularProgressIndicator(color: Colors.white, strokeWidth: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}
