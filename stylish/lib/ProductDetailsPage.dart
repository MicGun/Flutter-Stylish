import 'package:flutter/material.dart';
import 'package:stylish/ImageCardWeiget.dart';

import 'main.dart';

class ProductDetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductDetailsPage();
}

class _ProductDetailsPage extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(builder: (context, constraints) {
      var webLayout = Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xF1F4F8),
            title: Image.asset(
              'images/stylish_logo02.png',
              height: 24,
              fit: BoxFit.fitHeight,
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: const [
                  ImageCardWeiget(),
                  ImageCardWeiget(),
                ],
              ),
              Column(
                  children: const [
                    ImageCardWeiget(),
                    ImageCardWeiget(),
                    ImageCardWeiget(),
                    ImageCardWeiget(),
                    ImageCardWeiget(),
                    ImageCardWeiget(),
                    ImageCardWeiget(),
                    ImageCardWeiget(),
                ],
                ),
            ],
          ),
          ),
      );
      var mobileLayout = Scaffold(
        appBar: AppBar(
            title: Image.asset(
          'images/stylish_logo02.png',
          height: 24,
          fit: BoxFit.fitHeight,
        )),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              ImageCardWeiget(),
              ImageCardWeiget(),
              ImageCardWeiget(),
              ImageCardWeiget(),
              ImageCardWeiget(),
              ImageCardWeiget(),
              ImageCardWeiget(),
              ImageCardWeiget(),
          ],
          )
          ),
      );

      return (constraints.maxWidth > 700) ? webLayout : mobileLayout;
    });
  }

  
}
