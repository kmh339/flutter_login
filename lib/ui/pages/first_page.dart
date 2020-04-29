import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_login/blocs/login/login_bloc.dart';
import 'first.dart';

class FirstPage extends StatelessWidget {
  FirstPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
        },
        child: First(),
      ),
    );
  }
}
