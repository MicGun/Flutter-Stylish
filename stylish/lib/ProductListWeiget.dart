import 'package:flutter/cupertino.dart';
import 'package:stylish/product.dart';

import 'ProductWidget.dart';

class ProductListWidget extends StatelessWidget {
  ProductListWidget({
    super.key,
    required this.products,
    required this.listTitle,
    required this.onProductTap,
  });

  List<Product> products;
  String listTitle;
  ValueSetter<Product> onProductTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Text(
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            listTitle),
        Expanded(
          child: ListView(
            children: [
              for (Product product in products)
                ProductWidget(
                  product: product,
                  onProductTap: onProductTap,
                )
            ],
          ),
        )
      ],
    ));
  }
}
