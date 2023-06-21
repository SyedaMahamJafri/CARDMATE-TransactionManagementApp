import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/screens/signup/bloc/siginupEvents.dart';
import 'package:project/screens/signup/bloc/siginupStates.dart';
import 'package:project/screens/signup/repo/siginupRepo.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupRepository signupRepository;

  SignupBloc(this.signupRepository) : super(SignupInitial()) {
    on<SignupButtonPressed>((event, emit) async {
      emit(SignupLoading());
      try {
        await signupRepository.signup(
            event.signupModel, event.email, event.password);

        emit(SignupSuccess());
      } catch (error) {
        emit(SignupFailure(error.toString()));
      }
    });
  }
}
