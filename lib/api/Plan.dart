import 'package:dio/dio.dart';
import './config.dart';

Dio _dio = new Dio();

Future<dynamic> releasePlan({
  int userId,
  int month,
  String content,
}) async {
  FormData formData = FormData.fromMap({
    'user_id': userId,
    'plan_month': month,
    'plan_content': content,
  });
  Response response = await _dio.post(
    '$BASE_URL/plan/release-plan',
    data: formData,
  );
  return response.data;
}

Future<dynamic> getMonthPlan({
  int userId,
}) async {
  Response response = await _dio.get(
    '$BASE_URL/plan/plan-list',
    queryParameters: {
      'user_id': userId,
    },
  );
  return response.data;
}

Future<dynamic> deletePlan({
  int planId,
}) async {
  Response response = await _dio.get(
    '$BASE_URL/plan/delete-plan',
    queryParameters: {
      'plan_id': planId,
    },
  );
  return response.data;
}
