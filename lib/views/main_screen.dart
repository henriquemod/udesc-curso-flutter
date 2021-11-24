import 'package:flutter/material.dart';
import 'package:projeto_modulo_1/views/add_product_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> words = [];

  _navigator(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return const AddProduct();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de compras"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Flexible(
              flex: 6,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      color: Colors.red,
                      child: Center(
                        child: Text(words[index]),
                      ));
                },
                itemCount: words.length,
              )),
          const Flexible(
              flex: 1,
              child: Center(
                child: Text("Total: R\$00,00"),
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
