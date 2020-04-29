import 'package:flutter/material.dart';
import 'package:flutter_login/repositories/user_repository.dart';
import 'package:flutter_login/router/router.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Router.generateRoute,
      initialRoute: "/first",
      navigatorKey: Get.key,
    );
  }
}
