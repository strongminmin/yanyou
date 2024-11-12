import 'package:dio/dio.dart';
import './config.dart';

Dio _dio = new Dio();

Future<dynamic> getHistoryList({
  int userId,
  int page,
  int count,
}) async {
  Response response = await _dio.get(
    '$BASE_URL/history/history-list',
    queryParameters: {
      'user_id': userId,
      'page': page,
      'count': count,
    },
  );
  return response.data;
}

Future<dynamic> cleanHistory({
  int userId,
}) async {
  Response response = await _dio.get(
    '$BASE_URL/history/clean-history',
    queryParameters: {
      'user_id': userId,
    },
  );
  return response.data;
}
