import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_login/repositories/user_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  UserRepository _userRepository = UserRepository();

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppLoadedToState();
    }

    if (event is LoggedIn) {
      yield* _mapLoggedInWithApiToState();
    }

    if (event is LoggedOut) {
      yield* _mapLoggedOutWithApiToState();
    }
  }

  Stream<AuthenticationState> _mapAppLoadedToState() async* {
    final isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      yield Authenticated();
    } else {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInWithApiToState() async* {
    yield Authenticated();
  }

  Stream<AuthenticationState> _mapLoggedOutWithApiToState() async* {
    await _userRepository.deleteToken();
    yield Unauthenticated();
  }

//  // injection
//  set userRepository(UserRepository userRepository) =>
//      _userRepository = userRepository;
}
