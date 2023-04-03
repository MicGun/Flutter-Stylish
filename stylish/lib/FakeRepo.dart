import 'package:stylish/product.dart';
import 'package:stylish/productCategory.dart';

class FakeRepo {
  List<Product> getMenProducts() => <Product>[
        Product(
            productName: '超帥氣襯衫',
            imageSrc: 'images/men_clothes.jpg',
            price: '299'),
        Product(
            productName: '超帥氣襯衫',
            imageSrc: 'images/men_clothes.jpg',
            price: '299'),
        Product(
            productName: '超帥氣襯衫',
            imageSrc: 'images/men_clothes.jpg',
            price: '299'),
        Product(
            productName: '超帥氣襯衫',
            imageSrc: 'images/men_clothes.jpg',
            price: '299'),
        Product(
            productName: '超帥氣襯衫',
            imageSrc: 'images/men_clothes.jpg',
            price: '299'),
        Product(
            productName: '超帥氣襯衫',
            imageSrc: 'images/men_clothes.jpg',
            price: '299'),
      ];

  List<Product> getWomenProducts() => <Product>[
        Product(
            productName: '超漂亮約會裝扮',
            imageSrc: 'images/women_clothes.jpg',
            price: '399'),
        Product(
            productName: '超漂亮約會裝扮',
            imageSrc: 'images/women_clothes.jpg',
            price: '399'),
        Product(
            productName: '超漂亮約會裝扮',
            imageSrc: 'images/women_clothes.jpg',
            price: '399'),
        Product(
            productName: '超漂亮約會裝扮',
            imageSrc: 'images/women_clothes.jpg',
            price: '399'),
        Product(
            productName: '超漂亮約會裝扮',
            imageSrc: 'images/women_clothes.jpg',
            price: '399'),
        Product(
            productName: '超漂亮約會裝扮',
            imageSrc: 'images/women_clothes.jpg',
            price: '399'),
      ];

  List<Product> getAccessoryProducts() => <Product>[
        Product(
            productName: '必備率性皮帶',
            imageSrc: 'images/accessories.jpg',
            price: '199'),
        Product(
            productName: '必備率性皮帶',
            imageSrc: 'images/accessories.jpg',
            price: '199'),
        Product(
            productName: '必備率性皮帶',
            imageSrc: 'images/accessories.jpg',
            price: '199'),
        Product(
            productName: '必備率性皮帶',
            imageSrc: 'images/accessories.jpg',
            price: '199'),
        Product(
            productName: '必備率性皮帶',
            imageSrc: 'images/accessories.jpg',
            price: '199'),
        Product(
            productName: '必備率性皮帶',
            imageSrc: 'images/accessories.jpg',
            price: '199'),
      ];

  List<ProductCategory> getAllCategoryProducts() => <ProductCategory>[
    ProductCategory(category: "男裝", products: getMenProducts()),
    ProductCategory(category: "女裝", products: getWomenProducts()),
    ProductCategory(category: "配件", products: getAccessoryProducts()),
  ];
}
