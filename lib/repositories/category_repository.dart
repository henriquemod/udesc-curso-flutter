import 'package:projeto_modulo_1/models/category_model.dart';
import 'package:projeto_modulo_1/repositories/db_connection.dart';

class CategoryRepository {
  final String sqlSelectAll = 'SELECT * FROM category ;';

  Future<List<Category>> selectAll() async {
    List<Category> categoryList = [];

    List<Map<String, Object?>> json =
        await DbConnection().db!.rawQuery(sqlSelectAll);

    for (Map<String, Object?> element in json) {
      Category category = Category.fromMap(element);
      categoryList.add(category);
    }

    return categoryList;
  }
}
