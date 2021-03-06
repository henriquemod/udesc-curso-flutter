import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_modulo_1/controllers/add_product_controller.dart';
import 'package:projeto_modulo_1/controllers/categories_controller.dart';
import 'package:projeto_modulo_1/models/product_model.dart';
import 'package:projeto_modulo_1/utils/notify.dart';
import 'package:projeto_modulo_1/views/widgets/category_container.dart';
import 'package:projeto_modulo_1/views/widgets/text_input.dart';
import 'package:projeto_modulo_1/views/widgets/value_container.dart';

import '../utils/convert.dart';

// ignore: must_be_immutable
class AddProduct extends StatefulWidget {
  CategoryController catController;
  AddProduct({Key? key, required this.catController}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  AddProductController controller = AddProductController();
  ImagePicker imagePicker = ImagePicker();
  Uint8List? bytes;
  String? encoded;

  void _setImage(Uint8List bytess) {
    setState(() {
      bytes = bytess;
    });
  }

  void _addImage() async {
    try {
      XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var bytes = await image.readAsBytes();
        encoded = await Convert.encodeXFile(image);
        _setImage(bytes);
      }
    } catch (e) {
      Notify.snack(context: context, message: 'Falha ao adicionar a imagem');
    }
  }

  void _addProduct() async {
    if (controller.productNameController.text.isEmpty) {
      Notify.snack(
          context: context, message: 'Nome do item precisa ser preenchido');
    } else {
      Navigator.pop(
          context,
          Product(
              name: controller.productNameController.text,
              categoryId: widget.catController
                  .categories[widget.catController.selectedCat].id,
              value: double.parse(controller.productValueController.text),
              customThumbBase64: (encoded != null) ? encoded : 'unknown'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de compras"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              TextInput(
                controller: controller.productNameController,
                placeHolder: 'Nome do item',
              ),
              const SizedBox(height: 10),
              ValueContainer(
                controller: controller.productValueController,
              ),
              const SizedBox(height: 10),
              CategoryContainer(
                catController: widget.catController,
              ),
              const SizedBox(height: 10),
              if (bytes != null)
                Image.memory(
                  bytes!,
                  height: 100,
                ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _addImage,
                child: const Text('Adicionar foto do produto'),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _addProduct,
          icon: const Icon(Icons.playlist_add_check_rounded),
          label: const Text('Adicionar')),
    );
  }
}
