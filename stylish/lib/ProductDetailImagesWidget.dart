import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stylish/GradientText.dart';
import 'package:stylish/models/products_model.dart';
import 'package:flutter/painting.dart' as libColor;

class ProductDetailImagesWidget extends StatelessWidget {
  ProductDetailImagesWidget({super.key, required this.product});

  Datum product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 720,
      child: Column(
        children: [
          Row(
            children: const [
              GradientText(
                '細部說明',
                style: TextStyle(
                  fontSize: 16,
                ),
                gradient: LinearGradient(colors: [
                  libColor.Color(0xFF4B39EF),
                  libColor.Color(0xFF39D2C0),
                ]),
              ),
              Expanded(
                  child: Divider(
                color: Colors.black,
                height: 10,
                thickness: 1,
                indent: 10,
                endIndent: 0,
              )),
            ],
          ),
          Text(
            '''${product.story}''',
            style: const TextStyle(fontSize: 12),
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                      children: List.generate(
                product.images!.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Image.network(
                    product.images![index],
                    fit: BoxFit.cover,
                    height: 500,
                    width: 360,
                  ),
                ),
              ))),
            ],
          ),
        ],
      ),
    );
  }
}
