import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stylish/GradientText.dart';

class ProductDetailImagesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 720,
      child: Column(
        children: [
          Row(
              children: [
                GradientText(
                  '細部說明', 
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF4B39EF),
                      Color(0xFF39D2C0),
                  ]
                  ),
                  ),
                Expanded(
                  child: Divider(color: Colors.black, height: 10,thickness: 1, indent: 10, endIndent: 0,)
                  ),
              ],
            ),
            Text(
              '''O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.''',
              style: TextStyle(fontSize: 12),
              ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Image(
                          image: AssetImage('images/men_clothes.jpg'),
                          fit: BoxFit.fill,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Image(
                          image: AssetImage('images/men_clothes.jpg'),
                          fit: BoxFit.fill,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Image(
                          image: AssetImage('images/men_clothes.jpg'),
                          fit: BoxFit.fill,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Image(
                          image: AssetImage('images/men_clothes.jpg'),
                          fit: BoxFit.fill,
                          ),
                    ), 
                  ],
                  )
                ),
            ],
          ),
        ],
      ),
    );
  }
}
