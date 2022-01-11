import 'package:flutter/material.dart';
import 'package:projeto_modulo_1/controllers/categories_controller.dart';
import 'package:projeto_modulo_1/models/category_model.dart';
import 'package:projeto_modulo_1/views/widgets/action_button.dart';

class CategoryContainer extends StatefulWidget {
  final CategoryController catController;

  const CategoryContainer({Key? key, required this.catController})
      : super(key: key);

  @override
  _CategoryContainerState createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  void nextItem() {
    setState(() {
      widget.catController.nextCat();
    });
  }

  void previousItem() {
    setState(() {
      widget.catController.previousCat();
    });
  }

  @override
  Widget build(BuildContext context) {
    int catIndex = widget.catController.selectedCat;
    Category category = widget.catController.categories[catIndex];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ActionButton(
            callback: previousItem,
            icon: const Icon(Icons.arrow_downward),
            hint: 'Previous Category'),
        SizedBox(
          height: 100,
          width: 160,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(category.thumb),
              ),
              const Spacer(),
              Text(
                category.name,
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
        ActionButton(
            callback: nextItem,
            icon: const Icon(Icons.arrow_upward),
            hint: 'Next Category'),
      ],
    );
  }
}
