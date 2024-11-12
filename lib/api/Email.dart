import 'package:dio/dio.dart';
import './config.dart';

Dio _dio = new Dio();

Future<dynamic> sendEmail({
  String userEmail,
  String type,
}) async {
  Response response = await _dio.get(
    '$BASE_URL/email/send-email',
    queryParameters: {
      'user_email': userEmail,
      'type': type,
    },
  );
  return response.data;
}

Future<dynamic> checkIdentity({
  String userEmail,
  String identity,
}) async {
  Response response = await _dio.get(
    '$BASE_URL/email/check-identity',
    queryParameters: {
      'user_email': userEmail,
      'identity': identity,
    },
  );
  return response.data;
}
