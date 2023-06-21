/*import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project/screens/signup/bloc/siginupBloc.dart';
import 'package:project/screens/signup/bloc/siginupStates.dart';
import 'package:project/screens/signup/model/siginupModel.dart';
import 'package:project/screens/signup/repo/siginupRepo.dart';

import '../LoginBlocTest/LoginMockRepo.dart';
import 'SignUpMockRepo.dart';

// Create a mock repository for testing
class MockSignupRepository extends Mock implements SignupRepository {
   signup(SignupModel signupModel, String email, String password);
}

void main() {
  group('SignupBloc', () {
    SignupBloc signupBloc;
    MockSignupRepository mockSignupRepository;

    setUp(() {
      // Initialize the mock repository and the bloc
      mockSignupRepository = MockSignupRepository();
      signupBloc = SignupBloc(mockSignupRepository);
    });

    test('emits [SignupLoading, SignupSuccess] when SignupButtonPressed is added successfully', () {
      // Define the necessary test data
      final signupModel = SignupMockData[0];
      final email = 'test@example.com';
      final password = 'password';

      // Define the expected states that the bloc should emit
      final expectedStates = [
        SignupLoading(),
        SignupSuccess(),
      ];

      // Stub the repository's signup method to return successfully
      when(mockSignupRepository.signup(signupModel, email, password)).thenAnswer((_) async {});

    
    });

    test('emits [SignupLoading, SignupFailure] when SignupButtonPressed throws an error', () {
      // Define the necessary test data
      final signupModel = SignupModel(/* provide the necessary data */);
      final email = 'test@example.com';
      final password = 'password';
      final errorMessage = 'Failed to signup';

      // Define the expected states that the bloc should emit
      final expectedStates = [
        SignupLoading(),
        SignupFailure(errorMessage),
      ];

      // Stub the repository's signup method to throw an error
      when(mockSignupRepository.signup(signupModel, email, password)).thenThrow(errorMessage);

      // Add the SignupButtonPressed event to the bloc
      signupBloc.add(SignupButtonPressed(signupModel, email, password));

      // Expect that the bloc emits the expected states in the correct order
      expectLater(signupBloc.stream, emitsInOrder(expectedStates));
    });

    tearDown(() {
      // Close the bloc after each test
      signupBloc.close();
    });
  });
}*/
