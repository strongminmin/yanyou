import 'package:dio/dio.dart';
import './config.dart';

Dio _dio = new Dio();

Future<dynamic> getBannerList() async {
  Response response = await _dio.get('$BASE_URL/banner/banner-list');
  return response.data;
}
