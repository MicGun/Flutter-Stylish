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
  });

  List<ProductCategory> productCategories;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          child: ListView.builder(
              itemCount: productCategories.length,
              itemBuilder: (BuildContext context, int index) =>
                  ExpandableProductCategory(
                      index: index,
                      productCategory: productCategories[index]))),
    );
  }
}

class ExpandableProductCategory extends StatelessWidget {
  ExpandableProductCategory(
      {super.key, required this.productCategory, required this.index});

  int index;
  ProductCategory productCategory;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return ExpansionTile(
      initiallyExpanded: appState.selectedItem == index,
      title: Center(child: Text(productCategory.category)),
      children: productCategory.products
          .map((productItem) => ListTile(
                title: ProductWidget(product: productItem),
                onTap: () {},
              ))
          .toList(),
      onExpansionChanged: (isExpanded) {
        appState.itemSelected(isExpanded ? index : -1);
        // setState(() {
        //   if (isExpanded) {
        //     appState.itemSelected(widget.index);
        //   } else {
        //     appState.itemSelected(-1);
        //   }
        // });
      },
    );
  }
}
