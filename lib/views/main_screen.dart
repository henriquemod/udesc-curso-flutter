import 'package:flutter/material.dart';
import 'package:projeto_modulo_1/controllers/categories_controller.dart';
import 'package:projeto_modulo_1/controllers/product_list_controller.dart';
import 'package:projeto_modulo_1/models/category_model.dart';
import 'package:projeto_modulo_1/views/add_product_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ProductListController list = ProductListController();
  CategoryController catController = CategoryController();
  double totalValue = 00.00;

  addToLit(String name, int id, double value) {
    setState(() {
      list.addProduct(name, id, value);
      totalValue += value;
    });
  }

  removeFromList(int index, double value) {
    setState(() {
      list.removeProduct(index);
      totalValue -= value;
    });
  }

  clearList() {
    setState(() {
      list.clearList();
      totalValue = 00.00;
    });
  }

  subValue(double value) {
    setState(() {
      totalValue -= value;
    });
  }

  void _navigator(context) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const AddProduct(),
          fullscreenDialog: true,
        ));
    if (result != null) {
      addToLit(
          result[3],
          result[0],
          double.parse(
            result[1],
          ));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Adicionados ${result[1]} de ${result[2]}"),
        duration: const Duration(seconds: 2),
      ));
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
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(callbackMessage)));
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
                        removeFromList(index, list.getProducts()[index].value);
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
                  "Total: R\$${totalValue.toStringAsFixed(2)}",
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
