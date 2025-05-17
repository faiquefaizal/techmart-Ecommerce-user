part of 'auth_bloc.dart';

@immutable
sealed class AuthBlocEvent {}

class AuthCheckEvent extends AuthBlocEvent {}

class LogininEvent extends AuthBlocEvent {
  String email;
  String password;
  LogininEvent({required this.email, required this.password});
}

class Register extends AuthBlocEvent {
  String name;
  String password;
  String dob;
  String email;
  String gender;
  String phone;
  Register({
    required this.name,
    required this.password,
    required this.dob,
    required this.email,
    required this.gender,
    required this.phone,
  });
}

class GoogleSignInEvent extends AuthBlocEvent {}

class Logout extends AuthBlocEvent {}
