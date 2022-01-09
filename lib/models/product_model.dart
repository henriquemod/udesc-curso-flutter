import 'package:projeto_modulo_1/models/category_model.dart';

class Product {
  String name;
  Category cat;
  double value;
  double? latitude;
  double? longitude;
  String? customThumbBase64;

  Product(
      {required this.name,
      required this.cat,
      required this.value,
      this.customThumbBase64});
}
