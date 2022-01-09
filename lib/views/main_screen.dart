import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:projeto_modulo_1/controllers/categories_controller.dart';
import 'package:projeto_modulo_1/controllers/product_list_controller.dart';
import 'package:projeto_modulo_1/models/category_model.dart';
import 'package:projeto_modulo_1/models/product_model.dart';
import 'package:projeto_modulo_1/nav_bar.dart';
import 'package:projeto_modulo_1/utils/convert.dart';
import 'package:projeto_modulo_1/views/add_product_screen.dart';
import 'package:projeto_modulo_1/views/widgets/product_ink_well.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ProductListController list = ProductListController();
  CategoryController catController = CategoryController();
  LocationData? locationData;
  List<StreamSubscription> subscriptions = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocarion();
    subscriptions
        .add(Location.instance.onLocationChanged.listen(_listenLocationData));
  }

  void _getCurrentLocarion() async {
    locationData = await Location.instance.getLocation();
  }

  void _listenLocationData(LocationData event) {
    setState(() {
      locationData = event;
    });
  }

  void addToLit(Product product) {
    setState(() {
      list.addProduct(product);
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
    Product? product = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const AddProduct(),
          fullscreenDialog: true,
        ));

    if (product != null) {
      if (locationData != null) {
        product.latitude = locationData!.latitude;
        product.longitude = locationData!.longitude;
      }

      addToLit(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
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
              if (list.getProducts().isNotEmpty) {
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
          const SizedBox(height: 20),
          Flexible(
              flex: 6,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  Product currentProduct = list.getProduct(index);

                  MemoryImage? imageProvider;
                  if (currentProduct.customThumbBase64 != null) {
                    imageProvider = MemoryImage(Convert.decodeBase64Image(
                        currentProduct.customThumbBase64!));
                  }

                  Category? cat =
                      catController.getCategory(currentProduct.cat.id);
                  var curLat = (currentProduct.latitude != null)
                      ? currentProduct.latitude!.toStringAsFixed(4)
                      : 'N/A';
                  var curLong = (currentProduct.longitude != null)
                      ? currentProduct.longitude!.toStringAsFixed(4)
                      : 'N/A';
                  var subText =
                      'R\$ ${currentProduct.value.toStringAsFixed(2)}\n'
                      'Lat: $curLat - Long: $curLong';
                  return ProductInkWell(
                      index: index,
                      title: currentProduct.name,
                      subTitle: subText,
                      imageProvider: imageProvider,
                      thumb: cat.thumb,
                      handleRemove: removeFromList);
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
