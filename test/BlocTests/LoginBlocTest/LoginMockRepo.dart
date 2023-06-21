
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project/screens/login/bloc/loginBloc.dart';
import 'package:project/screens/login/bloc/loginEvents.dart';
import 'package:project/screens/login/bloc/loginStates.dart';
import 'package:project/screens/login/model/loginModel.dart';
import 'package:project/screens/login/repo/loginRepo.dart';

List<LoginModel> mockData = [
  LoginModel(
    email: "test1@x.com",
    password: "testcheck1",
    id: 1,
  ),
 LoginModel(
    email: "test2@x.com",
    password: "testcheck2",
    id: 2,
  ),
  LoginModel(
    email: "test3@x.com",
    password: "testcheck3",
    id: 3,
  ),
  LoginModel(
    email: "test4@x.com",
   password: "testcheck4",
    id: 4,
  ),
  LoginModel(
    email: "test5@x.com",
    password: "testcheck5",
    id: 5,
  ),
];



// Mock the LoginRepository class
class MockLoginRepository extends Mock implements LoginRepo {}

void main() {
  group('LoginBloc', () {
    LoginBloc loginBloc = LoginBloc(LoginRepo());
    MockLoginRepository mockLoginRepository = MockLoginRepository() ;

    setUp(() {
      mockLoginRepository = MockLoginRepository();
      loginBloc = LoginBloc(mockLoginRepository);
    });

    test('Initial state is LoginInitial', () {
      expect(loginBloc.state, equals(LoginInitial()));
    });

    test('LoginButtonPressed event triggers loading and success states on successful login', () async {
      const email = 'test@example.com';
      const password = 'password';

      // Set up the expected states emitted by the bloc
      final expectedStates = [
        LoginLoading(),
        LoginSuccess(),
      ];

      // When loginRepository.login is called, return true indicating a successful login
      when(mockLoginRepository.login(email, password)).thenAnswer((_) => Future.value(true));

      // Trigger the LoginButtonPressed event
      loginBloc.add(LoginButtonPressed(mockData[0].email!, mockData[0].password!));

      // Expect the bloc to emit the expected states in order
      expectLater(loginBloc.stream, emitsInOrder(expectedStates));

      // Wait for the test to complete
      await untilCalled(mockLoginRepository.login(email, password));

      // Verify that login was called with the correct email and password
      verify(mockLoginRepository.login(email, password));
    });

    test('LoginButtonPressed event triggers loading and failure states on failed login', () async {
      const email = 'test@example.com';
      const password = 'password';

      // Set up the expected states emitted by the bloc
      final expectedStates = [
        LoginLoading(),
        LoginFailure('Login Failed'),
      ];
      // When loginRepository.login is called, return false indicating a failed login
      when(mockLoginRepository.login(email, password)).thenAnswer((_) => Future.value(false));

      // Trigger the LoginButtonPressed event
      loginBloc.add(LoginButtonPressed(mockData[0].email!, mockData[0].password!));

      // Expect the bloc to emit the expected states in order
      expectLater(loginBloc.stream, emitsInOrder(expectedStates));

      // Wait for the test to complete
      await untilCalled(mockLoginRepository.login(email, password));

      // Verify that login was called with the correct email and password
      verify(mockLoginRepository.login(email, password));
    });

    // Add more test cases as needed
  });
}
