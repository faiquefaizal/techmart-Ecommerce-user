part of 'auth_bloc.dart';

@immutable
sealed class AuthBlocEvent {}

class AuthCheckEvent extends AuthBlocEvent {}

class LogininEvent extends AuthBlocEvent {
  final String email;
  final String password;
  LogininEvent({required this.email, required this.password});
}

class Register extends AuthBlocEvent {
  final String name;
  final String password;
  final String dob;
  final String email;
  final String? gender;
  final String phone;
  Register({
    required this.name,
    required this.password,
    required this.dob,
    required this.email,
    this.gender = "",
    required this.phone,
  });
}

class GoogleSignInEvent extends AuthBlocEvent {}

class Logout extends AuthBlocEvent {}
