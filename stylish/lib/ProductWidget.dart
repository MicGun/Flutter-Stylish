import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylish/product.dart';

class ProductWidget extends StatelessWidget {
  ProductWidget({super.key, required this.product});

  Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
            ),
            child: Image(
              image: AssetImage(product.imageSrc),
              fit: BoxFit.fill,
              height: 100,
              width: 80,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.productName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text('${product.currency} ${product.price}'),
            ],
          ),
        ],
      ),
    );
  }
}