import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;

  const TextInput({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      child: TextField(
        decoration: const InputDecoration(hintText: 'Nome da item'),
        controller: controller,
      ),
    );
  }
}
