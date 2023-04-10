import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/ImageCardWeiget.dart';
import 'package:stylish/ProductVariaantsWidget.dart';
import 'package:stylish/product.dart';

import 'ProductDetailImagesWidget.dart';
import 'main.dart';

class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage({
    super.key,
    required this.product,
  });
  Product product;
  @override
  State<StatefulWidget> createState() => _ProductDetailsPage();
}

class _ProductDetailsPage extends State<ProductDetailsPage> {
  
  @override
  Widget build(BuildContext context) {
    Product product = widget.product;
    return LayoutBuilder(builder: (context, constraints) {
      var webLayout = Scaffold(
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage('images/men_clothes.jpg'),
                      fit: BoxFit.fill,
                      height: 500,
                      width: 360,
                    ),
                  ),
                  ProductVariantsWidget(product: product,),
                ],
              ),
              Column(
                children: [
                  ProductDetailImagesWidget(),
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('images/men_clothes.jpg'),
                fit: BoxFit.fill,
                height: 500,
                width: 360,
              ),
            ),
            ProductVariantsWidget(product: product,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ProductDetailImagesWidget(),
            ),
          ],
        )),
      );

      return (constraints.maxWidth > 750) ? webLayout : mobileLayout;
    });
  }
}
