import 'package:dio/dio.dart';
import './config.dart';

Dio _dio = new Dio();

Future<dynamic> registerUser({
  String userEmail,
  String userName,
  String password,
}) async {
  FormData formData = FormData.fromMap({
    'user_email': userEmail,
    'user_name': userName,
    'user_password': password,
  });
  Response response = await _dio.post(
    '$BASE_URL/user/register',
    data: formData,
  );
  return response.data;
}

Future<dynamic> login({
  String userEmail,
  String password,
}) async {
  FormData formData = FormData.fromMap({
    'user_email': userEmail,
    'user_password': password,
    'platform': 'mobile'
  });
  Response response = await _dio.post('$BASE_URL/user/login', data: formData);
  return response.data;
}

Future<dynamic> updateUserInfo({
  int userId,
  String key,
  dynamic value,
}) async {
  if (key == 'user_image') {
    value = await MultipartFile.fromFile(value.path);
  }
  FormData formData = FormData.fromMap({
    'user_id': userId,
    'key': key,
    'value': value,
  });
  Response response = await _dio.post(
    '$BASE_URL/user/update',
    data: formData,
  );
  return response.data;
}
