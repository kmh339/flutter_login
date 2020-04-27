import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('second Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('To the last route \nargument :'),
          onPressed: () {
            Get.toNamed("/third");
          },
        ),
      ),
    );
  }
}
