import 'package:projeto_modulo_1/models/product_model.dart';
import 'package:projeto_modulo_1/repositories/product_repository.dart';

class ProductListController {
  ProductRepository productRepository = ProductRepository();
  late List<Product> productList;
  double listValue = 00.00;

  ProductListController() {
    productList = <Product>[];
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

  List<Product> getProducts() {
    return productList;
  }

  Product getProduct(int index) {
    return productList.elementAt(index);
  }

  addProduct(Product product) {
    productList.add(product);
    listValue += product.value;
  }

  removeProduct(int index) {
    listValue -= productList.elementAt(index).value;
    productList.removeAt(index);
  }

  clearList() {
    productList.clear();
    listValue = 00.00;
  }
}
