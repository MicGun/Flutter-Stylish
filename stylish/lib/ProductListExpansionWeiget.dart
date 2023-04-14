import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylish/product.dart';
import 'package:stylish/productCategory.dart';

import 'ProductWidget.dart';
import 'main.dart';

class ProductListExpansionWidget extends StatelessWidget {
  ProductListExpansionWidget({
    super.key,
    required this.productCategories,
    required this.onProductTap,
  });

  List<ProductCategory> productCategories;
  ValueSetter<Product> onProductTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          child: ListView.builder(
              itemCount: productCategories.length,
              itemBuilder: (BuildContext context, int index) =>
                  ExpandableProductCategory(
                    index: index,
                    productCategory: productCategories[index],
                    onProductTap: onProductTap,
                  ))),
    );
  }
}

class ExpandableProductCategory extends StatelessWidget {
  ExpandableProductCategory({
    super.key,
    required this.productCategory,
    required this.index,
    required this.onProductTap,
  });

  int index;
  ProductCategory productCategory;
  ValueSetter<Product> onProductTap;
  @override
  Widget build(BuildContext context) {
    return Text('Nothing Here');

    // Consumer<MyAppState>(
    //   builder: (context, value, child) => ExpansionTile(
    //     key: GlobalKey(),
    //     initiallyExpanded: value.selectedItem == index,
    //     title: Center(child: Text(productCategory.category)),
    //     children: productCategory.products
    //         .map((productItem) => ListTile(
    //               title: ProductWidget(
    //                 product: productItem,
    //                 onProductTap: onProductTap,
    //                 ),
    //               onTap: () {},
    //             ))
    //         .toList(),
    //     onExpansionChanged: (isExpanded) {
    //       value.itemSelected(isExpanded ? index : -1);
    //     },
    //   ),
    // );
  }
}
