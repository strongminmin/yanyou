import 'package:dio/dio.dart';
import './config.dart';

Dio _dio = new Dio();

Future<dynamic> getMeetList() async {
  Response response = await _dio.get('$BASE_URL/meet/meet-list');
  return response.data;
}

Future<dynamic> getMeetDetails({
  int userId,
  int meetId,
}) async {
  Response response = await _dio.get(
    '$BASE_URL/meet/meet-details',
    queryParameters: {
      'user_id': userId,
      'meet_id': meetId,
    },
  );
  return response.data;
}
