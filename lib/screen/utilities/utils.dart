import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class util {
  static void toastmessage(String massage) {
    Fluttertoast.showToast(
        msg: massage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
