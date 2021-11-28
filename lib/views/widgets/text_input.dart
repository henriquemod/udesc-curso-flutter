import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String placeHolder;
  final TextEditingController controller;

  const TextInput(
      {Key? key, required this.controller, required this.placeHolder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
      child: TextField(
        decoration: InputDecoration(hintText: placeHolder),
        controller: controller,
      ),
    );
  }
}
