import 'package:flutter/material.dart';
import 'package:flutter_login/ui/pages/first_page.dart';
import 'package:flutter_login/ui/pages/second.dart';
import 'package:flutter_login/ui/pages/third.dart';
import 'package:get/get.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return GetRoute(
          page: FirstPage(),
          settings: settings,
        );
      case '/second':
        return GetRoute(
          settings: settings,
          page: Second(),
          transition: Transition.cupertino,
        );
      case '/third':
        return GetRoute(
          settings: settings,
          page: Third(),
          popGesture: true,
          transition: Transition.cupertino,
        );
      default:
        return GetRoute(
            settings: settings,
            transition: Transition.fade,
            page: Scaffold(
              body:
                  Center(child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}
