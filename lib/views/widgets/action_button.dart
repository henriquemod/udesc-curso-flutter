import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Function callback;
  final Icon icon;
  final String hint;
  const ActionButton(
      {Key? key,
      required this.callback,
      required this.icon,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: IconButton(
        icon: icon,
        tooltip: hint,
        onPressed: () {
          callback();
        },
      ),
    );
  }
}
