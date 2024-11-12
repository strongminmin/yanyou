import 'dart:io';

import 'package:dio/dio.dart';
import './config.dart';

Dio _dio = new Dio();

Future<dynamic> getTalkList({
  int userId,
  int page,
  int count,
}) async {
  Response response = await _dio.get(
    '$BASE_URL/talk/talk-list',
    queryParameters: {
      'user_id': userId,
      'page': page,
      'count': count,
      'type': 'all',
    },
  );
  return response.data;
}

Future<dynamic> getSelfTalkList({
  int userId,
  int page,
  int count,
}) async {
  Response response = await _dio.get(
    '$BASE_URL/talk/talk-list',
    queryParameters: {
      'user_id': userId,
      'page': page,
      'count': count,
      'type': 'self',
    },
  );
  return response.data;
}

Future<dynamic> releaseTalk({
  int userId,
  String content,
  List<File> files,
}) async {
  List images = [];
  for (num i = 0; i < files.length; i++) {
    String path = files[i].path;
    images.add(await MultipartFile.fromFile(path));
  }
  FormData formData = FormData.fromMap({
    'user_id': userId,
    'images': images,
    'content': content,
  });
  Response response = await _dio.post(
    '$BASE_URL/talk/release-talk',
    data: formData,
  );
  return response.data;
}

Future<dynamic> talkLike({int userId, int targetId, int type}) async {
  Response response = await _dio.get(
    '$BASE_URL/talk/talk-like',
    queryParameters: {
      'user_id': userId,
      'target_id': targetId,
      'type': type,
    },
  );
  return response.data;
}

Future<dynamic> getCommentList({
  int userId,
  int targetId,
  int page,
  int count,
}) async {
  Response response = await _dio.get(
    '$BASE_URL/talk/talk-comment-list',
    queryParameters: {
      'user_id': userId,
      'target_id': targetId,
      'page': page,
      'count': count,
    },
  );
  return response.data;
}

Future<dynamic> releaseComment({
  int userId,
  int targetId,
  String commentContent,
}) async {
  FormData formData = FormData.fromMap({
    'user_id': userId,
    'target_id': targetId,
    'comment_content': commentContent,
  });
  Response response = await _dio.post(
    '$BASE_URL/talk/release-comment',
    data: formData,
  );
  return response.data;
}

Future<dynamic> deleteTalk({
  int talkId,
}) async {
  Response response = await _dio.get(
    '$BASE_URL/talk/delete-talk',
    queryParameters: {
      'talk_id': talkId,
    },
  );
  return response.data;
}
