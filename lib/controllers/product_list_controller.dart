import 'package:projeto_modulo_1/models/product_model.dart';

class ProductListController {
  late List<Product> productList;
  double listValue = 00.00;

  ProductListController() {
    productList = <Product>[];
  }

  List<Product> getProducts() {
    return productList;
  }

  addProduct(Product product) {
    this.productList.add(product);
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
