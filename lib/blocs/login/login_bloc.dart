import 'dart:async';
import 'dart:convert';

import 'package:flutter_login/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_login/models/user.dart';
import 'package:flutter_login/models/user_data.dart';
import 'package:flutter_login/models/user_meta.dart';
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

    }
  }

  Stream<LoginState> _mapLoginWithApiToState(String email, String password) async* {
    try {
      String body = json.encode({"email": email, "password": password});
      final response = await _amuseApiClient.post('/api/login', body, null);

      if(response != null) {
        print("]-----] _mapLoginWithApiToState : response [-----[ $response");
        User user = User.fromJson(response);
        UserData userData = user.data;
        UserMeta userMeta = user.meta;
        print("user token : ${userMeta.token}");
        print("Success Login");
        _userRepository.setUserData(userData);
        _userRepository.persistToken(userMeta.token);
//        _userRepository.persistName(userData.name);
        yield LoginSuccess();
      }
    } catch (_) {
      yield LoginFailure(error: "error in login");
    }
  }


//  // injection
//  set userRepository(UserRepository userRepository) =>
//      _userRepository = userRepository;
//
//  set authenticationBloc(AuthenticationBloc authenticationBloc) {
//    _authenticationBloc = authenticationBloc;
//  }
}
