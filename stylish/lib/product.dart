import 'package:stylish/ProductVariant.dart';

class Product {
  Product(
      {required this.id,
      required this.productName,
      required this.imageSrc,
      required this.price,
      required this.variants,
      required this.currency,
      });

  String id;
  String imageSrc;
  String productName = "";
  String currency = "NT\$";
  String price = "0";
  List<ProductVariant> variants;
}
