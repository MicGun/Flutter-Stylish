import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/models/products_model.dart';
import 'package:stylish/product.dart';

class ProductWidget2 extends StatelessWidget {
  ProductWidget2({
    super.key, 
    required this.product,
    required this.onProductTap,
    });

  Datum product;
  ValueSetter<Product> onProductTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap:() => GoRouter.of(context).go('/productDetails', extra: product),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
              child: Image.network('${product.mainImage}', height: 100, width: 80,),
              
              // Image(
              //   image: AssetImage(product.imageSrc),
              //   fit: BoxFit.fill,
              //   height: 100,
              //   width: 80,
              // ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                // Text('${product.currency} ${product.price}'),
                Text('NT ${product.price}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}