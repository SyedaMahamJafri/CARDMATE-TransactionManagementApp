import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/screens/login/bloc/loginEvents.dart';
import 'package:project/screens/login/bloc/loginStates.dart';
import 'package:project/screens/login/repo/loginRepo.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepo loginRepository;

  LoginBloc(this.loginRepository) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        bool check = await loginRepository.login(event.email, event.password);

        if (check) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure("Login Failed"));
        }
      } catch (error) {
        emit(LoginFailure(error.toString()));
      }
    });
  }
}
