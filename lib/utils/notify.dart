import 'package:flutter/material.dart';

class Notify {
  static void snack(
      {required BuildContext context, required String message, int? time}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: time ?? 1),
    ));
  }
}
