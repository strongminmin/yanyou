import 'package:dio/dio.dart';
import './config.dart';

Dio _dio = new Dio();

Future<dynamic> getCollegeList() async {
  Response response = await _dio.get('$BASE_URL/college/college-list');
  return response.data;
}

Future<dynamic> getCollegeDetails({
  int collegeId,
}) async {
  Response response = await _dio.get(
    '$BASE_URL/college/college-details',
    queryParameters: {'college_id': collegeId},
  );
  return response.data;
}
