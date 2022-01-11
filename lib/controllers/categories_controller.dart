import 'package:projeto_modulo_1/models/category_model.dart';

class CategoryController {
  late List<Category> categories;

  CategoryController({required this.categories});

  int selectedCat = 0;

  void nextCat() {
    selectedCat < categories.length ? selectedCat++ : selectedCat = 0;
  }

  void previousCat() {
    selectedCat--;
    selectedCat > 0 ? selectedCat-- : selectedCat = categories.length - 1;
  }

  Category getCategory(int index) {
    return categories.firstWhere((category) => category.id == index);
  }
}
