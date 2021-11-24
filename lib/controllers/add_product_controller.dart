import 'package:flutter/material.dart';

class AddProductController {
  final productNameController = TextEditingController();
  final productValueController = TextEditingController();

  AddProductController() {
    productValueController.text = "10,00";
  }
}
