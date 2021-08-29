import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    gravity: ToastGravity.CENTER,
    textColor: Colors.black,
    backgroundColor: Colors.white,
  );
}
