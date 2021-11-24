import 'dart:ffi';

import 'package:projeto_modulo_1/models/category_model.dart';

class Product {
  String name;
  Double value;
  Category cat;

  Product(this.name, this.value, this.cat);
}
