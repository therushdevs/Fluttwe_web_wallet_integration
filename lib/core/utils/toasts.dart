import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showWarningToast({required String warningMessage}) {
  Fluttertoast.showToast(
    msg: warningMessage,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
