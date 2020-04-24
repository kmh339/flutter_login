import 'package:flutter/material.dart';
import 'package:flutter_login/middleware/middleware.dart';
import 'package:flutter_login/router/router.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Router.generateRoute,
      navigatorKey: Get.key,
      initialRoute: "/",
      navigatorObservers: [
        GetObserver(MiddleWare.observer),
      ],
    );
  }
}
