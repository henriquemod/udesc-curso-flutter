import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  final TextEditingController controller;

  const CategoryContainer({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          child: const Icon(
            Icons.arrow_downward,
          ),
        ),
        Container(
          height: 50,
          width: 125,
          child: Column(
            children: [
              TextField(
                controller: controller,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20, // This is not so important
                ),
                enabled: false,
              )
            ],
          ),
        ),
        Container(
          height: 50,
          width: 50,
          child: const Icon(
            Icons.arrow_upward,
          ),
        ),
      ],
    );
  }
}