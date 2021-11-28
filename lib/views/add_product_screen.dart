import 'package:flutter/material.dart';
import 'package:projeto_modulo_1/controllers/add_product_controller.dart';
import 'package:projeto_modulo_1/controllers/categories_controller.dart';
import 'package:projeto_modulo_1/views/widgets/category_container.dart';
import 'package:projeto_modulo_1/views/widgets/text_input.dart';
import 'package:projeto_modulo_1/views/widgets/value_container.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  AddProductController controller = AddProductController();
  CategoryController catController = CategoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Lista de compras"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TextInput(
              controller: controller.productNameController,
              placeHolder: 'Nome do item',
            ),
            const Spacer(
              flex: 1,
            ),
            ValueContainer(
              controller: controller.productValueController,
            ),
            const Spacer(
              flex: 1,
            ),
            CategoryContainer(
              catController: catController,
            ),
            const Spacer(
              flex: 3,
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.productNameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Nome do item precisa ser preenchido"),
                    duration: Duration(seconds: 1),
                  ));
                } else {
                  Navigator.pop(context, [
                    catController.selectedCat,
                    controller.productValueController.text,
                    catController.categories[catController.selectedCat].name,
                    controller.productNameController.text
                  ]);
                }
              },
              child: const Text('Salvar'),
            ),
            const Spacer(
              flex: 4,
            ),
          ],
        ));
  }
}
