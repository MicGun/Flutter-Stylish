import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/cubit/product_cubit/product_state.dart';
import 'package:stylish/domain/category_domain.dart';
import 'package:stylish/models/products_model.dart';
import 'package:stylish/product.dart';
import 'package:stylish/widgets/default_loading_indicator.dart';

import 'ProductWidget copy.dart';
import 'ProductWidget.dart';
import 'cubit/product_cubit/product_cubit.dart';

class ProductListWidget extends StatefulWidget {
  ProductListWidget({
    super.key,
    // required this.products,
    required this.categoryType,
    required this.listTitle,
    required this.onProductTap,
  });

  // List<Product> products;
  String listTitle;
  ProductCategoryType categoryType;
  ValueSetter<Product> onProductTap;
  // Products products;

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  @override
  void initState() {}
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(widget.categoryType);
    }
    Products? value;
    if (widget.categoryType == ProductCategoryType.women) {
      value = context.watch<ProcuctCubit>().womenProducts;
    } else if (widget.categoryType == ProductCategoryType.men) {
      value = context.watch<ProcuctCubit>().menProducts;
    } else if (widget.categoryType == ProductCategoryType.accessories) {
      value = context.watch<ProcuctCubit>().accessoriesProducts;
    }

    return BlocBuilder<ProcuctCubit, ProductState>(
        builder: (context, state) => Expanded(
                child: Column(
              children: [
                Text(
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    widget.listTitle),
                Expanded(
                  child: (value != null && value.data != null)
                      ? ListView(
                          children: [
                            for (Datum product in value.data!)
                              ProductWidget2(
                                product: product,
                                onProductTap: widget.onProductTap,
                              )
                          ],
                        )
                      : const DefaultLoadingIndicator(
                          color: Colors.grey,
                        ),
                )
              ],
            ))
        // child:
        );
  }
}
