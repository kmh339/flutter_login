import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String arg = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('second Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('To the last route \nargument : ${arg}'),
          onPressed: () {
            Get.toNamed("/third");
          },
        ),
      ),
    );
  }
}
