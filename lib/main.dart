import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/common/common.dart';
import 'package:flutter_login/ui/login/login_page.dart';
import 'package:flutter_login/ui/pages/myapp.dart';
import 'package:flutter_login/ui/splash/splash_page.dart';
import 'package:get/get.dart';

import 'blocs/authentication/authentication_bloc.dart';
import 'blocs/authentication/authentication_event.dart';
import 'blocs/authentication/authentication_state.dart';
import 'ui/home/home_page.dart';

void main() => runApp(MyApp());

//void main() {
//  runApp(
//    BlocProvider<AuthenticationBloc>(
//      create: (context) {
//        return AuthenticationBloc()..add(AppStarted());
//      },
//      child: MyApp(),
//    ),
//  );
//}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Get.key,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage();
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          return SplashPage();
        },
      ),
    );
  }
}
