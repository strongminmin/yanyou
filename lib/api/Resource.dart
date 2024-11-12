import 'package:dio/dio.dart';
import './config.dart';

Dio _dio = new Dio();

Future<dynamic> getResourceList({
  int userId,
}) async {
  Response response = await _dio.get(
    '$BASE_URL/resource/resource-list',
    queryParameters: {
      'user_id': userId,
    },
  );
  return response.data;
}
