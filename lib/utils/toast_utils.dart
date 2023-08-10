import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static Future<bool?> showToast(
      {String? msg,
      ToastGravity toast = ToastGravity.TOP,
      bool error = false}) {
    return Fluttertoast.showToast(
        msg: msg ?? "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: toast,
        textColor: Colors.white,
        backgroundColor: error ? Colors.red : Colors.green,
        fontSize: 16.0);
  }
}
