import 'package:dio/dio.dart';

class ApiConfig {
  static const baseurl = "https://dummyjson.com/";
  static final Dio dio = Dio(BaseOptions(baseUrl: baseurl));

  static const products = "products";
}
