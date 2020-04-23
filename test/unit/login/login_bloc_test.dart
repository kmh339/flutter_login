import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_login/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_login/blocs/authentication/authentication_event.dart';
import 'package:flutter_login/blocs/login/login_bloc.dart';
import 'package:flutter_login/repositories/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

void main() {
  LoginBloc loginBloc;
  MockUserRepository mockUserRepository;
  MockAuthenticationBloc authenticationBloc;

  setUp(() {
    mockUserRepository = MockUserRepository();
    authenticationBloc = MockAuthenticationBloc();
    loginBloc = LoginBloc(
      authenticationBloc: authenticationBloc,
    );

    // inject mock
    loginBloc.userRepository = mockUserRepository;
  });

  tearDown(() {
    loginBloc?.close();
    authenticationBloc?.close();
  });

  test('throws AssertionError when authenticationBloc is null', () {
    expect(
      () => LoginBloc(
        authenticationBloc: null,
      ),
      throwsAssertionError,
    );
  });

  test('initial state is correct', () {
    expect(LoginInitial(), loginBloc.initialState);
  });

  test('close does not emit new states', () {
    expectLater(
      loginBloc,
      emitsInOrder([LoginInitial(), emitsDone]),
    );
    loginBloc.close();
  });

  group('LoginButtonPressed', () {
    blocTest(
      'emits [LoginLoading, LoginInitial] and token on success',
      build: () async {
        when(mockUserRepository.authenticate(
          username: 'valid.username',
          password: 'valid.password',
        )).thenAnswer((_) => Future.value('token'));
        return loginBloc;
      },
      act: (bloc) => bloc.add(
        LoginButtonPressed(
          username: 'valid.username',
          password: 'valid.password',
        ),
      ),
      expect: [
        LoginLoading(),
        LoginInitial(),
      ],
      verify: (_) async {
        verify(authenticationBloc.add(LoggedIn(token: 'token'))).called(1);
      },
    );

    blocTest(
      'emits [LoginLoading, LoginFailure] on failure',
      build: () async {
        when(mockUserRepository.authenticate(
          username: 'valid.username',
          password: 'valid.password',
        )).thenThrow(Exception('login-error'));
        return loginBloc;
      },
      act: (bloc) => bloc.add(
        LoginButtonPressed(
          username: 'valid.username',
          password: 'valid.password',
        ),
      ),
      expect: [
        LoginLoading(),
        LoginFailure(error: 'Exception: login-error'),
      ],
      verify: (_) async {
        verifyNever(authenticationBloc.add(any));
      },
    );
  });
}
