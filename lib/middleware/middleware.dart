import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MiddleWare {
  static observer(Routing routing) {
    ///Trigger any event when a route is pushed or popped by Get.
    /// You can listen in addition to the routes, the snackbars, dialogs and bottomsheets on each screen.
    ///If you need to enter any of these 3 events directly here,
    ///you must specify that the event is != Than you are trying to do.

    if (routing.current == '/second' && !routing.isSnackbar) {
      if (routing.isSnackbar) {
        print('snackbar');
      } else {
        print('not a snackbar');
      }
    } else if (routing.current == '/third') {
      print('last route called');
//      Get.snackbar(
//        'hello',
//        'world',
//        icon: Icon(Icons.alarm),
////        duration: Duration(seconds: 1),
//        shouldIconPulse: true,
//        isDismissible: true,
//      );
    }
  }
}
