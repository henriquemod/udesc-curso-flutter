import 'package:flutter/material.dart';
import 'package:projeto_modulo_1/models/category_model.dart';

class CategoryController {
  List<Category> categories = [
    Category(0, const AssetImage('assets/thumbs/bebidas.png'), "Bebidas"),
    Category(1, const AssetImage('assets/thumbs/biscoitos.png'), "Biscoitos"),
    Category(2, const AssetImage('assets/thumbs/cafes.png'), "Cafeinados"),
    Category(3, const AssetImage('assets/thumbs/carnes.png'), "Carnes"),
    Category(4, const AssetImage('assets/thumbs/frutas.png'), "Frutas"),
    Category(5, const AssetImage('assets/thumbs/fungos.png'), "Fungos"),
    Category(6, const AssetImage('assets/thumbs/lacteos.png'), "Lácteos"),
    Category(7, const AssetImage('assets/thumbs/legumes.png'), "Legumes"),
    Category(8, const AssetImage('assets/thumbs/raizes.png'), "Raizes"),
    Category(9, const AssetImage('assets/thumbs/sementes.png'), "Sementes"),
    Category(10, const AssetImage('assets/thumbs/vegetais.png'), "Vegetais"),
    Category(11, const AssetImage('assets/thumbs/verduras.png'), "Verduras"),
    Category(12, const AssetImage('assets/thumbs/doces.png'), "Doces")
  ];

  int selectedCat = 0;

  Category getCategory(int index) {
    return categories.elementAt(index);
  }
}
