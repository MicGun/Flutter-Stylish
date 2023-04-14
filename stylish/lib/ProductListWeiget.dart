import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/cubit/product_cubit/product_state.dart';
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
    required this.listTitle,
    required this.onProductTap,
  });

  // List<Product> products;
  String listTitle;
  ValueSetter<Product> onProductTap;
  // Products products;

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {

  @override
  void initState() {
    
  }
  @override
  Widget build(BuildContext context) {
    var value = context.watch<ProcuctCubit>().products;
    return BlocBuilder<ProcuctCubit, ProductState>(
      builder:(context, state) => Expanded(
          child: Column(
        children: [
          Text(
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              widget.listTitle),
          Expanded(
            child:(value.data != null)? ListView(
              children: [
                for (Datum product in value.data!)
                  ProductWidget2(
                    product: product,
                    onProductTap: widget.onProductTap,
                  )
              ],
            ) : DefaultLoadingIndicator(),
          )
        ],
      ))
      // child: 
    );
  }
}
