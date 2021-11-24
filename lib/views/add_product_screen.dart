import 'package:flutter/material.dart';
import 'package:projeto_modulo_1/controllers/add_product_controller.dart';
import 'package:projeto_modulo_1/views/widgets/text_input.dart';
import 'package:projeto_modulo_1/views/widgets/value_container.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  AddProductController controller = AddProductController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Lista de compras"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TextInput(controller: controller.productNameController),
            ValueContainer(
              controller: controller.productValueController,
            ),
            ElevatedButton(
              onPressed: () {
                // ignore: avoid_print
                print(controller.productNameController.text);
                controller.productNameController.clear();
              },
              child: const Text('Salvar'),
            ),
          ],
        ));
  }
}
