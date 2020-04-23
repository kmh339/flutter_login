import 'dart:async';

import 'package:flutter_login/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_login/blocs/authentication/authentication_event.dart';
import 'package:flutter_login/repositories/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthenticationBloc _authenticationBloc;
  UserRepository _userRepository = UserRepository();

  LoginBloc({@required AuthenticationBloc authenticationBloc})
      : assert(authenticationBloc != null),
        this._authenticationBloc = authenticationBloc;

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await _userRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        _authenticationBloc.add(LoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }

  // injection
  set userRepository(UserRepository userRepository) =>
      _userRepository = userRepository;

  set authenticationBloc(AuthenticationBloc authenticationBloc) {
    _authenticationBloc = authenticationBloc;
  }
}
