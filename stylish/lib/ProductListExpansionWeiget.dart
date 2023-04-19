import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
import 'domain/category_domain.dart';
import 'main.dart';
import 'models/products_model.dart';

class ProductListExpansionWidget extends StatefulWidget {
  ProductListExpansionWidget({
    super.key,
    required this.categoryTypes,
    // required this.productCategories,
    required this.onProductTap,
  });
  List<ProductCategoryType> categoryTypes;
  // List<ProductCategory> productCategories;
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
    // context.read<ProcuctCubit>().getAllProducts(0);
  }

  @override
  Widget build(BuildContext context) {
    var value = context.watch<ProcuctCubit>().products;
    if (kDebugMode) {
      print(widget.categoryTypes.length);
    }
    return Expanded(
        child: BlocBuilder<ProcuctCubit, ProductState>(
      builder: (context, state) => Container(
          child: getMobileProductListWidget(state, widget.onProductTap)
          // (value.data == null)
          //     ? const Center(
          //         child: DefaultLoadingIndicator(color: Colors.grey),
          //       )
          //     : ListView(
          //         children: List.generate(
          //             widget.categoryTypes.length,
          //             (index) => ExpandableProductCategory2(
          //                   index: index,
          //                   categoryType: widget.categoryTypes[index],
          //                   onProductTap: widget.onProductTap,
          //                 )),
                  // [
                  //   ExpandableProductCategory2(
                  //     title: '男裝',
                  //     products: value,
                  //     onProductTap: widget.onProductTap,
                  //     index: 0,
                  //   ),
                  //   ExpandableProductCategory2(
                  //     title: '女裝',
                  //     products: value,
                  //     onProductTap: widget.onProductTap,
                  //     index: 0,
                  //   ),
                  //   ExpandableProductCategory2(
                  //     title: '配件',
                  //     products: value,
                  //     onProductTap: widget.onProductTap,
                  //     index: 0,
                  //   )
                  // ],
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
    required this.categoryType,
    // required this.title,
    required this.index,
    required this.onProductTap,
  });
  // String title;
  int index;
  ProductCategoryType categoryType;
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
    // var value = context.watch<ProcuctCubit>().products;
    Products? value;
    if (widget.categoryType == ProductCategoryType.women) {
      value = context.watch<ProcuctCubit>().womenProducts;
    } else if (widget.categoryType == ProductCategoryType.men) {
      value = context.watch<ProcuctCubit>().menProducts;
    } else if (widget.categoryType == ProductCategoryType.accessories) {
      value = context.watch<ProcuctCubit>().accessoriesProducts;
    }

    return BlocBuilder<ProcuctCubit, ProductState>(builder: (context, state) {
      return ExpansionTile(
        key: GlobalKey(),
        initiallyExpanded: false,
        title: Center(
            child: Text(widget.categoryType.getProductCategoryTypeName())),
        children: (value != null && value.data != null)
            ? value.data!
                .map((productItem) => ListTile(
                      title: ProductWidget2(
                        product: productItem,
                        onProductTap: widget.onProductTap,
                      ),
                      onTap: () {},
                    ))
                .toList()
            : [
                const DefaultLoadingIndicator(
                  color: Colors.grey,
                )
              ],
        onExpansionChanged: (isExpanded) {},
      );
    });
  }
}

Widget getMobileProductListWidget(ProductState state, onProductTap) {
  if (kDebugMode) {
    print(state);
  }
  if (state is GetProductsFailureState) {
    return const Text('Failed to get products');
  } else if (state is GetProductsLoadingState) {
    return const DefaultLoadingIndicator(
      color: Colors.grey,
    );
  } else if (state is ShowLoadingState) {
    return const DefaultLoadingIndicator(
      color: Colors.grey,
    );
  } else if (state is GetProductsSuccessState) {
    var categoryTypes = ProductCategoryType.values;
    return ListView(
        children: List.generate(
            categoryTypes.length,
            (index) => ExpandableProductCategory2(
                  index: index,
                  categoryType: categoryTypes[index],
                  onProductTap: onProductTap,
                )));
  } else {
    return const Text('Failed to get products');
  }
}
