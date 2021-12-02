import 'package:flutter/material.dart';
import 'package:projeto_modulo_1/controllers/categories_controller.dart';
import 'package:projeto_modulo_1/controllers/product_list_controller.dart';
import 'package:projeto_modulo_1/models/category_model.dart';
import 'package:projeto_modulo_1/models/product_list_model.dart';
import 'package:projeto_modulo_1/views/add_product_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ProductListController list = ProductListController();
  CategoryController catController = CategoryController();

  void addToLit(ProductList productList) {
    setState(() {
      list.addProduct(productList);
    });
  }

  void removeFromList(int index) {
    setState(() {
      list.removeProduct(index);
    });
  }

  void clearList() {
    setState(() {
      list.clearList();
    });
  }

  void _navigator(context) async {
    var product = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const AddProduct(),
          fullscreenDialog: true,
        ));
    if (product != null) {
      addToLit(product[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de compras"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.clear,
            ),
            tooltip: 'Clear List',
            onPressed: () {
              String callbackMessage = "Lista já esta vazia";
              if (list.getProducts().length > 0) {
                clearList();
                callbackMessage = 'Lista limpa';
              }
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(callbackMessage),
                duration: const Duration(seconds: 1),
              ));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
              flex: 6,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  Category? cat = catController
                      .findCategory(list.getProducts()[index].productID);
                  return InkWell(
                      child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: (cat!.thumb),
                      backgroundColor: Colors
                          .transparent, // no matter how big it is, it won't overflow
                    ),
                    title: Text(list.getProducts()[index].name,
                        style: const TextStyle(
                          fontSize: 18,
                        )),
                    subtitle: Text(
                        'R\$${list.getProducts()[index].value.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                      ),
                      tooltip: 'Remove item',
                      onPressed: () {
                        removeFromList(index);
                      },
                    ),
                  ));
                },
                itemCount: list.getProducts().length,
              )),
          Flexible(
              flex: 1,
              child: Center(
                child: Text(
                  "Total: R\$${list.listValue.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigator(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
