import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/models/user_data.dart';
import 'package:flutter_login/repositories/user_repository.dart';
import 'package:flutter_login/ui/login/login_page.dart';
import 'package:get/get.dart';

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  final _userRepository = UserRepository();
  String userName;

  @override
  void initState() {
    super.initState();
    _userRepository.getName().then((name){
      setState(() {
        userName = name;
      });
      print("userName initstate : $userName");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Get.snackbar("hi", "i am a modern snackbar");
          },
        ),
        title: Text('Hello $userName'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('To the 2nd route'),
              onPressed: () {
                Get.toNamed("/second", arguments: "$userName", );
              },
            ),
            RaisedButton(
              child: Text('Logout'),
              onPressed: () {
                print("logout");
                _userRepository.deleteUserInfo();

                Get.offAll(LoginPage());
              },
            ),
          ],

        ),
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
  }
}
