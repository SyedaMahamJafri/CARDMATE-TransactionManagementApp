import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/screens/signup/model/siginupModel.dart';
import 'package:project/screens/userhome/bloc/userHomeEvents.dart';
import 'package:project/screens/userhome/bloc/userHomeStates.dart';
import 'package:project/screens/userhome/repo/userHomeRepo.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  final UserHomeRepository repository;

  UserHomeBloc(this.repository) : super(UserHomeInitial()) {
    on<FetchDataEvent>((event, emit) async {
      emit(UserHomeLoading());
      try {
        User? user = FirebaseAuth.instance.currentUser;

        await repository
            .getUserByUid(user!.uid)
            .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.exists) {
            Map<String, dynamic> data = snapshot.data()!;
            if (data != null) {
              SignupModel userData = SignupModel.fromJson(data);
              emit(UserHomeSuccess(userData));
            } else {
              emit(UserHomeFailure("User data is null"));
            }
          } else {
            emit(UserHomeFailure("User not found"));
          }
        });
      } catch (error) {
        print(error);
        emit(UserHomeFailure(error.toString()));
      }
    });
  }
}
