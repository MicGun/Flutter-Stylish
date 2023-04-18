import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:stylish/product.dart';
import 'package:stylish/productCategory.dart';
import 'package:stylish/widgets/default_loading_indicator.dart';

import 'ProductWidget copy.dart';
import 'ProductWidget.dart';
import 'cubit/product_cubit/product_cubit.dart';
import 'cubit/product_cubit/product_state.dart';
import 'main.dart';
import 'models/products_model.dart';

class ProductListExpansionWidget extends StatefulWidget {
  ProductListExpansionWidget({
    super.key,
    required this.productCategories,
    required this.onProductTap,
  });

  List<ProductCategory> productCategories;
  ValueSetter<Product> onProductTap;

  @override
  State<ProductListExpansionWidget> createState() =>
      _ProductListExpansionWidgetState();
}

class _ProductListExpansionWidgetState
    extends State<ProductListExpansionWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ProcuctCubit>().getAllProducts(0);
  }

  @override
  Widget build(BuildContext context) {
    var value = context.watch<ProcuctCubit>().products;
    return Expanded(
      child: Container(
          child: (value.data == null)
              ? const Center(
                  child: DefaultLoadingIndicator(color: Colors.grey),
                )
              : ListView(
                  children: [
                    ExpandableProductCategory2(
                      title: '男裝',
                      products: value,
                      onProductTap: widget.onProductTap,
                      index: 0,
                    ),
                    ExpandableProductCategory2(
                      title: '女裝',
                      products: value,
                      onProductTap: widget.onProductTap,
                      index: 0,
                    ),
                    ExpandableProductCategory2(
                      title: '配件',
                      products: value,
                      onProductTap: widget.onProductTap,
                      index: 0,
                    )
                  ],
                )
          // ListView.builder(
          //     itemCount: productCategories.length,
          //     itemBuilder: (BuildContext context, int index) =>
          //         ExpandableProductCategory(
          //           index: index,
          //           productCategory: productCategories[index],
          //           onProductTap: onProductTap,
          //         )
          //         )
          ),
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
    return
        // BlocBuilder<ProcuctCubit, ProductState>(builder: (context, state) {
        //   return Text('Nothing Here');
        // });

        Consumer<MyAppState>(
      builder: (context, value, child) => ExpansionTile(
        key: GlobalKey(),
        initiallyExpanded: value.selectedItem == index,
        title: Center(child: Text(productCategory.category)),
        children: productCategory.products
            .map((productItem) => ListTile(
                  title: ProductWidget(
                    product: productItem,
                    onProductTap: onProductTap,
                  ),
                  onTap: () {},
                ))
            .toList(),
        onExpansionChanged: (isExpanded) {
          value.itemSelected(isExpanded ? index : -1);
        },
      ),
    );
  }
}

class ExpandableProductCategory2 extends StatefulWidget {
  ExpandableProductCategory2({
    super.key,
    required this.products,
    required this.title,
    required this.index,
    required this.onProductTap,
  });
  String title;
  int index;
  Products products;
  ValueSetter<Product> onProductTap;

  @override
  State<ExpandableProductCategory2> createState() =>
      _ExpandableProductCategory2State();
}

class _ExpandableProductCategory2State
    extends State<ExpandableProductCategory2> {
  @override
  void initState() {
    super.initState();
    // context.read<ProcuctCubit>().getAllProducts(0);
  }

  @override
  Widget build(BuildContext context) {
    var value = context.watch<ProcuctCubit>().products;

    return BlocBuilder<ProcuctCubit, ProductState>(builder: (context, state) {
      return ExpansionTile(
        key: GlobalKey(),
        initiallyExpanded: false,
        title: Center(child: Text(widget.title)),
        children: (widget.products.data == null)
            ? [Text('no data')]
            : widget.products.data!
                .map((productItem) => ListTile(
                      title: ProductWidget2(
                        product: productItem,
                        onProductTap: widget.onProductTap,
                      ),
                      onTap: () {},
                    ))
                .toList(),
        onExpansionChanged: (isExpanded) {},
      );
    });
  }
}
