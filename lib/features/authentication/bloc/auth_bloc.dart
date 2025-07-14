import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techmart/features/authentication/service/Auth_service.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthService authService = AuthService();

  AuthBlocBloc() : super(AuthBlocInitial()) {
    on<AuthCheckEvent>(_authcheck);
    on<LogininEvent>(_login);
    on<Register>(_register);
    on<GoogleSignInEvent>(_googlesignin);
    on<Logout>(_logout);
  }

  void _authcheck(AuthCheckEvent event, Emitter<AuthBlocState> emit) async {
    final sharedpref = await SharedPreferences.getInstance();

    final _isFirst = sharedpref.getBool("_isfirst") ?? false;
    log("auth check created");
    try {
      await Future.delayed(Duration(seconds: 3));
      if (!_isFirst) {
        await sharedpref.setBool("_isfirst", true);
        log("welcome emit");
        emit(WelcomeState());
        return;
      } else if (await authService.checkUser()) {
        log("autheticated emit");
        emit(Authticated(authService.getUserId()!));
      } else {
        emit(UnAuthenticated());
      }
    } on FirebaseAuthException catch (e) {
      log("errorauth");
      emit(ErrorAuth(e.message.toString()));
    }
  }

  void _login(LogininEvent event, Emitter<AuthBlocState> emit) async {
    log("_loginAithcreated");
    await Future.delayed(Duration(seconds: 3));
    log("_loadingstate");
    emit(AuthBlocLoading());

    try {
      String? user = await authService.signInUser(
        email: event.email,
        password: event.password,
      );
      if (user != null) {
        log("authiticatedstate");
        emit(Authticated(user));
      } else {
        log("unauthicatedstate");
        emit(UnAuthenticated());
      }
    } on FirebaseAuthException catch (e) {
      log("error f");
      emit(ErrorAuth("firebasererror ${e.message.toString()}"));
    }
  }

  void _register(Register event, Emitter<AuthBlocState> emit) async {
    log("loading");
    emit(AuthBlocLoading());
    await Future.delayed(Duration(seconds: 3));
    try {
      String? user = await authService.registerUser(
        name: event.name,
        passord: event.password,
        dob: event.dob,
        email: event.email,
        gender: event.gender,
        phone: event.phone,
      );
      if (user != null) {
        log("authicated");
        emit(Authticated(user));
      } else {
        log("not");
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(ErrorAuth(e.toString()));
    }
  }

  _googlesignin(GoogleSignInEvent event, Emitter<AuthBlocState> emit) async {
    try {
      final userid = await authService.googleSignIn();
      emit(Authticated(userid));
    } catch (e) {
      emit(ErrorAuth(e.toString()));
    }
  }

  _logout(Logout event, Emitter<AuthBlocState> emit) {
    try {
      authService.signOut();
      emit(UnAuthenticated());
    } catch (e) {
      emit(ErrorAuth(e.toString()));
    }
  }
}
