import 'package:dio/dio.dart';
import './config.dart';

Dio _dio = new Dio();

Future<dynamic> getCheckList({
  int userId,
}) async {
  Response response = await _dio.get(
    '$BASE_URL/check/check-list',
    queryParameters: {
      'user_id': userId,
    },
  );
  return response.data;
}

Future<dynamic> checkIn({
  int userId,
}) async {
  Response response = await _dio.get(
    '$BASE_URL/check/check-in',
    queryParameters: {
      'user_id': userId,
    },
  );
  return response.data;
}

Future<dynamic> getUserChecked({
  int userId,
}) async {
  Response response = await _dio.get(
    '$BASE_URL/check/checked',
    queryParameters: {'user_id': userId},
  );
  return response.data;
}
