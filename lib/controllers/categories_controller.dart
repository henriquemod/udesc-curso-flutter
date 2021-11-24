import 'package:flutter/material.dart';
import 'package:projeto_modulo_1/models/category_model.dart';

class CategoryController {
  List<Category> categories = [
    Category(const AssetImage('assets/thumbs/Butter.png'), "Manteiga"),
    Category(const AssetImage('assets/thumbs/Carrot.png'), "Cenoura"),
    Category(const AssetImage('assets/thumbs/Garlic.png'), "Alho"),
    Category(const AssetImage('assets/thumbs/Ice_Cream.png'), "Sorvete"),
    Category(const AssetImage('assets/thumbs/Jellybeans.png'), "Jujubas"),
    Category(const AssetImage('assets/thumbs/Meat.png'), "Carne"),
    Category(const AssetImage('assets/thumbs/Monster_Lasagna.png'), "Lasanha"),
    Category(const AssetImage('assets/thumbs/Onion.png'), "Cebola"),
    Category(const AssetImage('assets/thumbs/Pepper.png'), "Pimenta"),
    Category(const AssetImage('assets/thumbs/Potato.png'), "Batata"),
    Category(const AssetImage('assets/thumbs/Pumpkin_Cookies.png'), "Cookies")
  ];

  /*
  CategoryController() {
    categories.add(
        Category(const AssetImage('assets/thumbs/Butter.png'), "Manteiga"));
  }*/
}
