import 'package:dio/dio.dart';
import './config.dart';

Dio _dio = new Dio();

Future<dynamic> getAdvisoryList({
  int page,
  int count,
}) async {
  Response response = await _dio.get(
    '$BASE_URL/advisory/advisory-list',
    queryParameters: {
      'page': page,
      'count': count,
    },
  );
  return response.data;
}

Future<dynamic> getAdvisoryDetails({int userId, int advisoryId}) async {
  Response response = await _dio.get(
    '$BASE_URL/advisory/advisory-details',
    queryParameters: {
      'user_id': userId,
      'advisory_id': advisoryId,
    },
  );
  return response.data;
}

Future<dynamic> advisoryReward({
  int advisoryId,
}) async {
  Response response = await _dio.get(
    '$BASE_URL/advisory/advisory-reward',
    queryParameters: {
      'advisory_id': advisoryId,
    },
  );
  return response.data;
}
