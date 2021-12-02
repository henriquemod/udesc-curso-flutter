import 'package:projeto_modulo_1/models/product_list_model.dart';

class ProductListController {
  late List<ProductList> productList;
  double listValue = 00.00;

  ProductListController() {
    productList = <ProductList>[];
  }

  List<ProductList> getProducts() {
    return productList;
  }

  addProduct(ProductList productList) {
    this.productList.add(productList);
    listValue += productList.value;
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
