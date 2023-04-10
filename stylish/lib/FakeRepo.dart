import 'package:stylish/ProductVariant.dart';
import 'package:stylish/product.dart';
import 'package:stylish/productCategory.dart';

class FakeRepo {
  List<Product> getMenProducts() => <Product>[
        Product(
            id: '2023001001',
            productName: '超帥氣襯衫',
            imageSrc: 'images/men_clothes.jpg',
            price: '299',
            variants: getFakeVariants()),
        Product(
            id: '2023001001',
            productName: '超帥氣襯衫',
            imageSrc: 'images/men_clothes.jpg',
            price: '299',
            variants: getFakeVariants()),
        Product(
            id: '2023001001',
            productName: '超帥氣襯衫',
            imageSrc: 'images/men_clothes.jpg',
            price: '299',
            variants: getFakeVariants()),
        Product(
            id: '2023001001',
            productName: '超帥氣襯衫',
            imageSrc: 'images/men_clothes.jpg',
            price: '299',
            variants: getFakeVariants()),
        Product(
            id: '2023001001',
            productName: '超帥氣襯衫',
            imageSrc: 'images/men_clothes.jpg',
            price: '299',
            variants: getFakeVariants()),
        Product(
            id: '2023001001',
            productName: '超帥氣襯衫',
            imageSrc: 'images/men_clothes.jpg',
            price: '299',
            variants: getFakeVariants()),
      ];

  List<Product> getWomenProducts() => <Product>[
        Product(
            id: '2023001001',
            productName: '超漂亮約會裝扮',
            imageSrc: 'images/women_clothes.jpg',
            price: '399',
            variants: getFakeVariants()),
        Product(
            id: '2023001001',
            productName: '超漂亮約會裝扮',
            imageSrc: 'images/women_clothes.jpg',
            price: '399',
            variants: getFakeVariants()),
        Product(
            id: '2023001001',
            productName: '超漂亮約會裝扮',
            imageSrc: 'images/women_clothes.jpg',
            price: '399',
            variants: getFakeVariants()),
        Product(
            id: '2023001001',
            productName: '超漂亮約會裝扮',
            imageSrc: 'images/women_clothes.jpg',
            price: '399',
            variants: getFakeVariants()),
        Product(
            id: '2023001001',
            productName: '超漂亮約會裝扮',
            imageSrc: 'images/women_clothes.jpg',
            price: '399',
            variants: getFakeVariants()),
        Product(
            id: '2023001001',
            productName: '超漂亮約會裝扮',
            imageSrc: 'images/women_clothes.jpg',
            price: '399',
            variants: getFakeVariants()),
      ];

  List<Product> getAccessoryProducts() => <Product>[
        Product(
            id: '2023001001',
            productName: '必備率性皮帶',
            imageSrc: 'images/accessories.jpg',
            price: '199',
            variants: getFakeVariants()),
        Product(
            id: '2023001001',
            productName: '必備率性皮帶',
            imageSrc: 'images/accessories.jpg',
            price: '199',
            variants: getFakeVariants()),
        Product(
            id: '2023001001',
            productName: '必備率性皮帶',
            imageSrc: 'images/accessories.jpg',
            price: '199',
            variants: getFakeVariants()),
        Product(
            id: '2023001001',
            productName: '必備率性皮帶',
            imageSrc: 'images/accessories.jpg',
            price: '199',
            variants: getFakeVariants()),
        Product(
            id: '2023001001',
            productName: '必備率性皮帶',
            imageSrc: 'images/accessories.jpg',
            price: '199',
            variants: getFakeVariants()),
        Product(
            id: '2023001001',
            productName: '必備率性皮帶',
            imageSrc: 'images/accessories.jpg',
            price: '199',
            variants: getFakeVariants()),
      ];

  List<ProductCategory> getAllCategoryProducts() => <ProductCategory>[
        ProductCategory(category: "男裝", products: getMenProducts()),
        ProductCategory(category: "女裝", products: getWomenProducts()),
        ProductCategory(category: "配件", products: getAccessoryProducts()),
      ];

  List<ProductVariant> getFakeVariants() => <ProductVariant>[
    ProductVariant(id: '001', size: 'S', colorName: 'Red', colorCode: '0xffff0000', inStock: true),
    ProductVariant(id: '002', size: 'S', colorName: 'Blue', colorCode: '0xff0000ff', inStock: true),
    ProductVariant(id: '003', size: 'S', colorName: 'Yellow', colorCode: '0xffffff00', inStock: true),
    ProductVariant(id: '004', size: 'M', colorName: 'Red', colorCode: '0xffff0000', inStock: true),
    ProductVariant(id: '005', size: 'M', colorName: 'Blue', colorCode: '0xff0000ff', inStock: true),
    ProductVariant(id: '006', size: 'M', colorName: 'Yellow', colorCode: '0xffffff00', inStock: true),
    ProductVariant(id: '007', size: 'L', colorName: 'Red', colorCode: '0xffff0000', inStock: true),
    ProductVariant(id: '008', size: 'L', colorName: 'Blue', colorCode: '0xff0000ff', inStock: true),
    ProductVariant(id: '009', size: 'L', colorName: 'Yellow', colorCode: '0xffffff00', inStock: false),
    ProductVariant(id: '010', size: 'XL', colorName: 'Red', colorCode: '0xffff0000', inStock: true),
    ProductVariant(id: '011', size: 'XL', colorName: 'Blue', colorCode: '0xff0000ff', inStock: true),
    ProductVariant(id: '012', size: 'XL', colorName: 'Yellow', colorCode: '0xffffff00', inStock: true),
  ];
}
