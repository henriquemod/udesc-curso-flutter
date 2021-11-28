import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ValueContainer extends StatelessWidget {
  final TextEditingController controller;

  const ValueContainer({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: IconButton(
            icon: const Icon(Icons.arrow_downward),
            tooltip: 'Decrease value',
            onPressed: () {
              double value = double.parse(controller.text);
              if (value - 10.00 > 0.0) {
                value -= 10.00;
              } else {
                value = 00.00;
              }
              controller.text = value.toStringAsFixed(2);
            },
          ),
        ),
        SizedBox(
          height: 50,
          width: 150,
          child: Column(
            children: [
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                controller: controller,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20, // This is not so important
                ),
                enabled: true,
              )
            ],
          ),
        ),
        SizedBox(
          height: 50,
          width: 50,
          child: IconButton(
            icon: const Icon(Icons.arrow_upward),
            tooltip: 'Increase value',
            onPressed: () {
              double value = double.parse(controller.text);
              value += 10.00;
              controller.text = value.toStringAsFixed(2);
            },
          ),
        ),
      ],
    );
  }
}
