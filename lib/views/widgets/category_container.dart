import 'package:flutter/material.dart';
import 'package:projeto_modulo_1/controllers/categories_controller.dart';

class CategoryContainer extends StatefulWidget {
  final CategoryController catController;

  const CategoryContainer({Key? key, required this.catController})
      : super(key: key);

  @override
  _CategoryContainerState createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  //CategoryController catController = CategoryController();
  //int catId = 0;

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
        SizedBox(
          height: 50,
          width: 50,
          child: IconButton(
            icon: const Icon(Icons.arrow_downward),
            tooltip: 'Previous Category',
            onPressed: () {
              previousItem();
            },
          ),
        ),
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
        SizedBox(
          height: 50,
          width: 50,
          child: IconButton(
            icon: const Icon(Icons.arrow_upward),
            tooltip: 'Next Category',
            onPressed: () {
              nextItem();
            },
          ),
        ),
      ],
    );
  }
}
