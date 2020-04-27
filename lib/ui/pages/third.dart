import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Third extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Third Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
//            Get.toNamed("/second");
          print("get back");
          Get.back();
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
