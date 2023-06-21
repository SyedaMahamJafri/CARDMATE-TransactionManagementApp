
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project/screens/login/bloc/loginBloc.dart';
import 'package:project/screens/login/bloc/loginEvents.dart';
import 'package:project/screens/login/bloc/loginStates.dart';
import 'package:project/screens/login/loginUI.dart';
import 'package:project/screens/login/model/loginModel.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:project/screens/login/repo/loginRepo.dart';
import 'package:equatable/equatable.dart';

import 'LoginMockRepo.dart';
void main() {
  group("UserBloc Test", () {
    late LoginBloc loginBloc;
    late MockLoginRepository mockUserRepo;

    setUp(() {
      EquatableConfig.stringify = true;
      mockUserRepo = MockLoginRepository();
      loginBloc = LoginBloc(mockUserRepo);
    });

    // All Success
    blocTest<LoginBloc, LoginState>(
      "test for Read success",
      build: () => loginBloc,
      act: (bloc) => bloc.add( LoginButtonPressed('mahamj@x.com', '123456')),
      wait: const Duration(seconds: 2),
      expect: () => [ isA<LoginLoading>(), isA<LoginFailure>()],
    );

   
    tearDown(() async {
      await loginBloc.close();
    });
  });
}