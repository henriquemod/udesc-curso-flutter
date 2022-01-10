import 'package:flutter/material.dart';

class ProductInkWell extends StatelessWidget {
  final int index;
  final String title;
  final String subTitle;
  final MemoryImage? imageProvider;
  final AssetImage thumb;
  final Function handleRemove;

  const ProductInkWell(
      {Key? key,
      required this.index,
      required this.title,
      required this.subTitle,
      required this.imageProvider,
      required this.thumb,
      required this.handleRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: ListTile(
      minVerticalPadding: 20,
      leading: (imageProvider != null)
          ? CircleAvatar(
              radius: 30,
              backgroundImage: imageProvider,
              backgroundColor: Colors
                  .transparent, // no matter how big it is, it won't overflow
            )
          : CircleAvatar(
              radius: 30,
              backgroundImage: thumb,
              backgroundColor: Colors
                  .transparent, // no matter how big it is, it won't overflow
            ),
      title: Text(title,
          style: const TextStyle(
            fontSize: 18,
          )),
      subtitle: Text(subTitle),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete_outline,
        ),
        tooltip: 'Remove item',
        onPressed: () {
          handleRemove(index);
        },
      ),
    ));
  }
}
