import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylish/product.dart';
import 'package:stylish/productCategory.dart';

import 'ProductWidget.dart';

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
                      productCategory: productCategories[index]))),
    );
  }
}

class ExpandableProductCategory extends StatelessWidget {
  ExpandableProductCategory({super.key, required this.productCategory});

  ProductCategory productCategory;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Text(productCategory.category),
        children: productCategory.products
            .map((productItem) => ProductWidget(product: productItem))
            .toList());
  }
}
