import 'package:projeto_modulo_1/models/product_model.dart';
import 'package:projeto_modulo_1/repositories/product_repository.dart';

class ProductListController {
  ProductRepository productRepository = ProductRepository();
  late List<Product> productList;
  late double listValue;

  ProductListController() {
    productList = <Product>[];
    listValue = getTotalValue();
  }

  double getTotalValue() {
    if (productList.isNotEmpty) {
      Product sumProduct = productList.reduce((firstProd, secondProd) =>
          Product(
              name: 'SumProduct',
              value: firstProd.value + secondProd.value,
              categoryId: secondProd.categoryId,
              customThumbBase64: 'unknown'));
      return sumProduct.value;
    } else {
      return 00.00;
    }
  }

  // ANCHOR
  Future<void> getAllProducts() async {
    List<Product> result = await productRepository.selectAll();
    productList = result;
  }

  // ANCHOR
  Future<void> register(Product product) async {
    await productRepository.insert(product);
  }

  // ANCHOR
  Future<void> clear() async {
    await productRepository.deleteAll();
  }

  // ANCHOR
  Future<void> removeItem(int productId) async {
    await productRepository.delete(productId);
  }

  /*
  List<Product> getProducts() {
    return productList;
  }
  */
  Product getProduct(int index) {
    return productList.elementAt(index);
  }
}
