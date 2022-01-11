import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:projeto_modulo_1/controllers/categories_controller.dart';
import 'package:projeto_modulo_1/controllers/product_list_controller.dart';
import 'package:projeto_modulo_1/models/category_model.dart';
import 'package:projeto_modulo_1/models/product_model.dart';
import 'package:projeto_modulo_1/nav_bar.dart';
import 'package:projeto_modulo_1/repositories/category_repository.dart';
import 'package:projeto_modulo_1/utils/convert.dart';
import 'package:projeto_modulo_1/views/add_product_screen.dart';
import 'package:projeto_modulo_1/views/notifications_screen.dart';
import 'package:projeto_modulo_1/views/widgets/product_ink_well.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/notifications_api.dart';
import '../repositories/db_connection.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late CategoryRepository repository = CategoryRepository();
  late SharedPreferences sharedPreferences;
  ProductListController list = ProductListController();
  late CategoryController catController;
  LocationData? locationData;
  List<StreamSubscription> subscriptions = [];
  Map<int, MemoryImage> thumbMap = {};
  bool loading = true;
  late int notificationFrequency;

  // ANCHOR LOAD CONTENT
  _loadContent() async {
    List<Category> result = await repository.selectAll();
    catController = CategoryController(categories: result);

    setState(() {
      loading = true;
    });

    list.getAllProducts().whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  // ANCHOR REGISTER PRODUCT
  _registerProduct(Product product) {
    setState(() {
      loading = true;
    });
    list.register(product).whenComplete(_loadContent);
  }

  // ANCHOR
  _clearProductList() {
    setState(() {
      loading = true;
    });
    list.clear().whenComplete(() {
      thumbMap.clear();
      _loadContent();
    });
  }

  // ANCHOR
  _removeFromList(int productId, int index) {
    setState(() {
      loading = true;
    });
    list.removeItem(productId).whenComplete(() {
      thumbMap.remove(index);
      _loadContent();
    });
  }

  @override
  void initState() {
    super.initState();
    DbConnection().conn().whenComplete(_loadContent);
    SharedPreferences.getInstance()
        .then((value) => {sharedPreferences = value});

    NotificationApi.init();
    listenNotifications();
    _getCurrentLocarion();
    subscriptions
        .add(Location.instance.onLocationChanged.listen(_listenLocationData));
  }

  listenNotifications() {
    NotificationApi.onNotification.stream.listen((event) {
      if (event == "simples.01") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return const MainScreen();
        }));
      }
    });
  }

  void _getCurrentLocarion() async {
    locationData = await Location.instance.getLocation();
  }

  void _listenLocationData(LocationData event) {
    if (locationData != null) {
      if (locationData!.latitude != event.latitude ||
          locationData!.longitude != event.longitude) {
        setState(() {
          locationData = event;
        });
      }
    }
  }

  void _navigator(context) async {
    Product? product = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              AddProduct(catController: catController),
          fullscreenDialog: true,
        ));

    if (product != null) {
      if (locationData != null) {
        product.latitude = locationData!.latitude;
        product.longitude = locationData!.longitude;
      }

      _registerProduct(product);
    }
  }

  void notificationNavigator(context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              NotificationScreen(sharedPreferences: sharedPreferences),
          fullscreenDialog: true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(notificationNavigation: notificationNavigator),
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
              if (list.productList.isNotEmpty) {
                _clearProductList();
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
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        Product currentProduct = list.productList[index];

                        MemoryImage? imageProvider;
                        if (currentProduct.customThumbBase64 != null &&
                            currentProduct.customThumbBase64 != 'unknown') {
                          if (thumbMap.containsKey(index)) {
                            imageProvider = thumbMap[index];
                          } else {
                            imageProvider = MemoryImage(
                                Convert.decodeBase64Image(
                                    currentProduct.customThumbBase64!));
                            thumbMap.addAll({index: imageProvider});
                          }
                        }

                        Category cat = catController
                            .getCategory(currentProduct.categoryId);
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
                            productId: currentProduct.id,
                            title: currentProduct.name,
                            subTitle: subText,
                            imageProvider: imageProvider,
                            thumb: AssetImage(cat.thumb),
                            handleRemove: _removeFromList);
                      },
                      itemCount: list.productList.length,
                    )),
          Flexible(
              flex: 1,
              child: Center(
                child: Text(
                  "Total: R\$${list.getTotalValue().toStringAsFixed(2)}",
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
