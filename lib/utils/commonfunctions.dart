import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
void displayMessage(String message,BuildContext context) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: Theme.of(context).primaryColor,
      textColor: Theme.of(context).accentColor,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      fontSize: 14.0);
}

