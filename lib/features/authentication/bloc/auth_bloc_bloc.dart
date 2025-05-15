import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:techmart/features/authentication/service/Auth_service.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthService authService = AuthService();

  AuthBlocBloc() : super(AuthBlocInitial()) {
    on<AuthCheckEvent>(_authcheck);
    on<LogininEvent>(_login);
    on<Register>(_register);
  }

  void _authcheck(AuthCheckEvent event, Emitter<AuthBlocState> emit) {
    try {
      if (authService.checkUserLogedIn() == true) {
        emit(WelcomeState());
      } else if (authService.checkUser()) {
        emit(Authticated(authService.getUserId()!));
      }
    } catch (e) {
      emit(ErrorAuth(e.toString()));
    }
  }

  void _login(LogininEvent event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
    try {
      String? user = await authService.signInUser(
        email: event.email,
        password: event.password,
      );
      if (user != null) {
        emit(Authticated(user));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(ErrorAuth(e.toString()));
    }
  }

  _register(Register event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
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
        emit(Authticated(user));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(ErrorAuth(e.toString()));
    }
  }
}
