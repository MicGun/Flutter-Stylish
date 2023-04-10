// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartProduct {
  String id;
  String imageSrc;
  String productName;
  String currency = "NT\$";
  String price;
  String totalPrice;
  String colorName;
  String colorCode;
  String size;
  int amount;

  CartProduct({
    required this.id,
    required this.imageSrc,
    required this.productName,
    required this.currency,
    required this.price,
    required this.totalPrice,
    required this.colorName,
    required this.colorCode,
    required this.size,
    required this.amount,
  });
}
