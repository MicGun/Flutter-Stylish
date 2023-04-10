import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/CartProduct.dart';
import 'package:stylish/product.dart';

class CartProductWidget extends StatelessWidget {
  CartProductWidget({super.key, required this.product});

  CartProduct product;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
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
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        product.productName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          ChoiceChip(
                            avatar: Card(
                              color: hexToColor(product.colorCode),
                              child: const SizedBox(
                                width: 20,
                                height: 20,
                              ),
                            ),
                            label: Text(product.size),
                            labelPadding: const EdgeInsets.only(
                              left: 12,
                              right: 12,
                            ),
                            selected: false,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            onSelected: (value) {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${product.currency} ${product.price}'),
                      const SizedBox(
                        height: 8,
                      ),
                      Text('x ${product.amount}'),
                      const SizedBox(
                        height: 8,
                      ),
                      Text('${product.currency} ${product.totalPrice}'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
      ),
    );
  }

  Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }
}
