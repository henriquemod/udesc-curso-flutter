import 'package:projeto_modulo_1/models/product_list_model.dart';

class ProductListController {
  late List<ProductList> productList;

  ProductListController() {
    productList = <ProductList>[];
  }

  getProducts() {
    return productList;
  }

  addProduct(String name, int productID, double value) {
    productList.add(ProductList(name, productID, value));
  }

  removeProduct(int index) {
    productList.removeAt(index);
  }

  clearList() {
    productList.clear();
  }
}
