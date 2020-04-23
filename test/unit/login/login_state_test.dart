import 'package:flutter_login/blocs/login/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginState', () {
    group('LoginInitial', () {
      test('props are []', () {
        expect(LoginInitial().props, []);
      });

      test('toString is LoginInitial', () {
        expect(LoginInitial().toString(), 'LoginInitial');
      });
    });

    group('LoginLoading', () {
      test('props are []', () {
        expect(LoginLoading().props, []);
      });

      test('toString is LoginLoading', () {
        expect(LoginLoading().toString(), 'LoginLoading');
      });
    });

    group('LoginFailure', () {
      test('props are [error]', () {
        expect(LoginFailure(error: 'error').props, ['error']);
      });

      test('toString is LoginFailure { error: error }', () {
        expect(
          LoginFailure(error: 'error').toString(),
          'LoginFailure { error: error }',
        );
      });
    });
  });
}
