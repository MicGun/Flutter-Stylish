import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stylish/CartProduct.dart';
import 'package:stylish/CartProductWidget.dart';
import 'package:stylish/product.dart';

import 'main.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShoppingCartPage();
}

class _ShoppingCartPage extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
            onPressed: () => GoRouter.of(context).go('/'),
          ),
          backgroundColor: const Color(0xF1F4F8),
          title: Image.asset(
            'images/stylish_logo02.png',
            height: 24,
            fit: BoxFit.fitHeight,
          ),
        ),
        body: (value.cartProducts.length == 0)
            ? Center(
                child: Text('購物車目前沒有商品'),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        for (CartProduct product in value.cartProducts)
                          CartProductWidget(
                            product: product,
                            removeProductListener: (product) {
                              value.removeProductfromCart(product);
                            },
                          )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
