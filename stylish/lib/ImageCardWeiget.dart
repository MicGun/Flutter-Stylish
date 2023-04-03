import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageCardWeiget extends StatelessWidget {
  const ImageCardWeiget({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: const [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
              child: Image(
                image: AssetImage('images/muji_banner.jpg'),
                fit: BoxFit.fill,
                height: 150,
                width: 300,
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding placeholder() {
    return const Padding(
      padding: EdgeInsets.all(10),
      // ignore: prefer_const_constructors
      child: Card(
        color: Colors.amberAccent,
        borderOnForeground: true,
        child: SizedBox(
          height: 150,
          width: 300,
        ),
      ),
    );
  }
}