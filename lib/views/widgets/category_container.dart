import 'package:flutter/material.dart';
import 'package:projeto_modulo_1/controllers/categories_controller.dart';
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
      widget.catController.selectedCat <
              widget.catController.categories.length - 1
          ? widget.catController.selectedCat++
          : widget.catController.selectedCat = 0;
    });
  }

  void previousItem() {
    setState(() {
      widget.catController.selectedCat--;
      widget.catController.selectedCat > 0
          ? widget.catController.selectedCat--
          : widget.catController.selectedCat =
              widget.catController.categories.length - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ActionButton(
            callback: previousItem,
            icon: const Icon(Icons.arrow_downward),
            hint: 'Previous Category'),
        SizedBox(
          height: 100,
          width: 150,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  image: widget.catController
                      .categories[widget.catController.selectedCat].thumb),
              const Spacer(),
              Text(
                  widget.catController
                      .categories[widget.catController.selectedCat].name,
                  style: const TextStyle(fontSize: 18))
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
