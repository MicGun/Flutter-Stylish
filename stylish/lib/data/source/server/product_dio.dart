import 'dart:io';

import 'package:dio/dio.dart';

import 'api_result_handler.dart';

class ProductDio {
  late Dio dio;

  ProductDio() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: 'https://api.appworks-school.tw/api/1.0/',
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
    dio = Dio(baseOptions);
  }

  Future<ApiResults> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
    };
    try {
      var response = await dio.get(endPoint, queryParameters: queryParameters);
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure('Error');
    } on FormatException {
      return ApiFailure('Error');
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        // return ApiFailure(e.response!.data['message']);
        return ApiFailure(e.message!);
      } else if (e.type == DioErrorType.connectionTimeout) {
        // print('check your connection');
        return ApiFailure('connrect timeout');
      } else if (e.type == DioErrorType.receiveTimeout) {
        // print('unable to connect to the server');
        return ApiFailure('receive timeout');
      } else {
        return ApiFailure('Something wrong');
      }
    } catch (e) {
      return ApiFailure('async wrong');
    }
  }

  Future<ApiResults> postData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool formData = true,
    String? token,
  }) async {
    dio.options.headers = {
      "Accept": "application/json",
    };

    try {
      var response = await dio.post(
        endPoint,
        data: formData ? FormData.fromMap(data ?? {}) : data,
        queryParameters: queryParameters,
      );
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure('Error');
    } on FormatException {
      return ApiFailure('Error');
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        // return ApiFailure(e.response!.data['message']);
        return ApiFailure(e.message!);
      } else if (e.type == DioErrorType.connectionTimeout) {
        // print('check your connection');
        return ApiFailure('connrect timeout');
      } else if (e.type == DioErrorType.receiveTimeout) {
        // print('unable to connect to the server');
        return ApiFailure('receive timeout');
      } else {
        return ApiFailure('Something wrong');
      }
    } catch (e) {
      return ApiFailure('async wrong');
    }
  }
}
