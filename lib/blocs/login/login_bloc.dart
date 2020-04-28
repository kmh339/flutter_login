import 'dart:async';
import 'dart:convert';

import 'package:flutter_login/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_login/repositories/user_repository.dart';
import 'package:flutter_login/services/amuse_api_client.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthenticationBloc _authenticationBloc;
  UserRepository _userRepository = UserRepository();
  AmuseApiClient _amuseApiClient = AmuseApiClient();

  LoginBloc({@required AuthenticationBloc authenticationBloc})
      : assert(authenticationBloc != null),
        this._authenticationBloc = authenticationBloc;

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
      Stream<LoginEvent> events,
      TransitionFunction<LoginEvent, LoginState> transitionFn,
      ) {
    final nonDebounceStream = events.where((event) {
      return (event is! LoginButtonPressed);
    });
    final debounceStream = events.where((event) {
      return (event is LoginButtonPressed);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      yield* _mapLoginWithApiToState(event.email, event.password);


//      yield LoginLoading();
//
//      try {
//        final token = await _userRepository.authenticate(
//          username: event.username,
//          password: event.password,
//        );
//        _authenticationBloc.add(LoggedIn(token: token));
//        yield LoginInitial();
//
//
//      } catch (error) {
//        yield LoginFailure(error: error.toString());
//      }
    }
  }

  Stream<LoginState> _mapLoginWithApiToState(String email, String password) async* {
    try {
      String body = json.encode({"email": email, "password": password});
      final response = await _amuseApiClient.postForLogin('/api/login', body);

      if(response != null) {
        print("${response['data']}");
        print("Success Login");
        yield LoginSuccess();
      }
    } catch (_) {
      yield LoginFailure(error: "error in login");
    }
  }

  // injection
  set userRepository(UserRepository userRepository) =>
      _userRepository = userRepository;

  set authenticationBloc(AuthenticationBloc authenticationBloc) {
    _authenticationBloc = authenticationBloc;
  }
}
