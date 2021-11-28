import 'package:flutter/material.dart';
import 'package:projeto_modulo_1/models/category_model.dart';

class CategoryController {
  int selectedCat = 0;
  List<Category> categories = [
    Category(0, const AssetImage('assets/thumbs/Butter.png'), "Manteiga"),
    Category(1, const AssetImage('assets/thumbs/Carrot.png'), "Cenoura"),
    Category(2, const AssetImage('assets/thumbs/Garlic.png'), "Alho"),
    Category(3, const AssetImage('assets/thumbs/Ice_Cream.png'), "Sorvete"),
    Category(4, const AssetImage('assets/thumbs/Jellybeans.png'), "Jujubas"),
    Category(5, const AssetImage('assets/thumbs/Meat.png'), "Carne"),
    Category(
        6, const AssetImage('assets/thumbs/Monster_Lasagna.png'), "Lasanha"),
    Category(7, const AssetImage('assets/thumbs/Onion.png'), "Cebola"),
    Category(8, const AssetImage('assets/thumbs/Pepper.png'), "Pimenta"),
    Category(9, const AssetImage('assets/thumbs/Potato.png'), "Batata"),
    Category(
        10, const AssetImage('assets/thumbs/Pumpkin_Cookies.png'), "Cookies")
  ];

  CategoryController();

  findCategory(int id) {
    for (var cat in categories) {
      if (cat.id == id) {
        return cat;
      }
    }
  }
}
