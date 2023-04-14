import 'package:stylish/data/source/server/api_result_handler.dart';
import 'package:stylish/data/source/server/endpoints.dart';
import 'package:stylish/data/source/server/product_dio.dart';

class ProductReposiroty {

  Future<ApiResults> getAllProducts() async {
    return await ProductDio().getData(endPoint: productAll);
  }

  Future<ApiResults> getWomenProducts() async {
    return await ProductDio().getData(endPoint: productWomen);
  }

  Future<ApiResults> getMenProducts() async {
    return await ProductDio().getData(endPoint: productMen);
  }

  Future<ApiResults> getAccessoriesProducts() async {
    return await ProductDio().getData(endPoint: productAccessories);
  }
}
