import 'package:projeto_modulo_1/models/product_model.dart';
import 'package:projeto_modulo_1/repositories/db_connection.dart';

class ProductRepository {
  final String sqlSelectAll =
      'SELECT * FROM product LEFT JOIN category ON product.category_id = category.category_id;';
  final String sqlInsert =
      'INSERT INTO product (name, category_id, custom_thumb_base64, value, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?)';
  final String sqlUpdate =
      'UPDATE product SET name = ?, category_id = ?, custom_thumb_base64 = ?, value = ?, latitude = ?, longitude = ?  WHERE id = ?';
  final String sqlDelete = 'DELETE FROM product WHERE id = ?';
  final String sqlDeleteAll = 'DELETE FROM product';

  Future<List<Product>> selectAll() async {
    List<Product> productList = [];

    List<Map<String, Object?>> json =
        await DbConnection().db!.rawQuery(sqlSelectAll);

    for (Map<String, Object?> element in json) {
      Product product = Product.fromMap(element);
      productList.add(product);
    }

    return productList;
  }

  Future<void> insert(Product product) async {
    await DbConnection().db!.rawInsert(sqlInsert, [
      product.name,
      product.categoryId,
      product.customThumbBase64,
      product.value,
      product.latitude,
      product.longitude
    ]);
  }

  Future<void> update(Product product) async {
    await DbConnection().db!.rawUpdate(sqlUpdate, [
      product.name,
      product.categoryId,
      product.customThumbBase64,
      product.value,
      product.latitude,
      product.longitude,
      product.id
    ]);
  }

  Future<void> delete(int productId) async {
    await DbConnection().db!.rawDelete(sqlDelete, [productId]);
  }

  Future<void> deleteAll() async {
    await DbConnection().db!.rawDelete(sqlDeleteAll);
  }
}
