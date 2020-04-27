import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_login/blocs/authentication/authentication_event.dart';
import 'package:flutter_login/router/router.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Router.generateRoute,
      initialRoute: "/",
      navigatorKey: Get.key,
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('Home'),
//        ),
//        body: Container(
//          child: Center(
//              child: RaisedButton(
//            child: Text('logout'),
//            onPressed: () {
//              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
//            },
//          )),
//        ),
//      ),
    );
  }
}
