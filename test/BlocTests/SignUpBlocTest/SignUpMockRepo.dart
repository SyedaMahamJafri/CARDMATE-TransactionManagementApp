
import 'package:project/screens/signup/model/siginupModel.dart';
import 'package:project/screens/signup/repo/siginupRepo.dart';

import '../LoginBlocTest/LoginMockRepo.dart';

List<SignupModel> SignupMockData = <SignupModel>[
  SignupModel(
    firstName: 'Test',
    lastName: 'User1',
    gender: 'male',
    phonenumber: '03425678910',
    uid: "1"),
  SignupModel(
    firstName: 'Test',
    lastName: 'User2',
    gender: 'female',
    phonenumber: '034954789103',
      uid: "2"),
  SignupModel(
    firstName: 'Test',
    lastName: 'User3',
    gender: 'male',
    phonenumber: '03428302910',
      uid: "3"),
];

class MockSignupRepository implements SignupRepository {
  @override
  AddUser(firstname, lastname, gender, phoneNumber, String uid) async {
    Future.delayed(
        const Duration(seconds: 2),
        () => SignupMockData.add(SignupModel(
            firstName: firstname,
            lastName: lastname,
            gender: gender,
            phonenumber: phoneNumber,
            uid: uid)));
  }
  
  @override
  Future<void> signup(SignupModel user, String email, String password)async {
     Future.delayed(
        const Duration(seconds: 2),
        () => SignupMockData.add(user ));

  }
  
  
}