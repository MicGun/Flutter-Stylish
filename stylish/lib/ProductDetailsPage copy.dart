import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/ImageCardWeiget.dart';
import 'package:stylish/ProductVariaantsWidget.dart';
import 'package:stylish/models/products_model.dart';
import 'package:stylish/product.dart';

import 'ProductDetailImagesWidget.dart';
import 'ProductVariaantsWidget copy.dart';
import 'main.dart';
import 'package:flutter/painting.dart' as libColor;

class ProductDetailsPage2 extends StatefulWidget {
  ProductDetailsPage2({
    super.key,
    required this.product,
  });
  Datum product;
  @override
  State<StatefulWidget> createState() => _ProductDetailsPage2();
}

class _ProductDetailsPage2 extends State<ProductDetailsPage2> {
  
  @override
  Widget build(BuildContext context) {
    Datum product = widget.product;
    return LayoutBuilder(builder: (context, constraints) {
      var webLayout = Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
            onPressed: () => GoRouter.of(context).go('/'),
          ),
          backgroundColor: libColor.Color(0xF1F4F8),
          title: Image.asset(
            'images/stylish_logo02.png',
            height: 24,
            fit: BoxFit.fitHeight,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image.network(
                      '${product.mainImage}',
                      fit: BoxFit.fill,
                      height: 500,
                      width: 360,
                    ),
                  ),
                  ProductVariantsWidget2(product: product,),
                ],
              ),
              Column(
                children: [
                  ProductDetailImagesWidget(product: product,),
                ],
              ),
            ],
          ),
        ),
      );
      var mobileLayout = Scaffold(
        appBar: AppBar(
            leading: BackButton(
              color: Colors.black,
              onPressed: () => GoRouter.of(context).go('/'),
            ),
            title: Image.asset(
              'images/stylish_logo02.png',
              height: 24,
              fit: BoxFit.fitHeight,
            )),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.network(
                      '${product.mainImage}',
                      fit: BoxFit.fill,
                      height: 500,
                      width: 360,
                    ),
            ),
            ProductVariantsWidget2(product: product,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ProductDetailImagesWidget(product: product,),
            ),
          ],
        )),
      );

      return (constraints.maxWidth > 750) ? webLayout : mobileLayout;
    });
  }
}
