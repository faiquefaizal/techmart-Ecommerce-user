part of 'auth_bloc.dart';

@immutable
sealed class AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}

final class AuthBlocLoading extends AuthBlocState {}

final class WelcomeState extends AuthBlocState {}

final class Authticated extends AuthBlocState {
  final String authicated;
  Authticated(this.authicated);
}

final class ErrorAuth extends AuthBlocState {
  final String error;
  ErrorAuth(this.error);
}

final class UnAuthenticated extends AuthBlocState {}
