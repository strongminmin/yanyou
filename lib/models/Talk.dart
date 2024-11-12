import 'dart:convert';

class TalkModel extends Object {
  int talkId;
  int userId;
  String talkContent;
  List<String> talkImages;
  String createTime;
  String userName;
  String userImage;
  Like talkLike;
  int comment;
  int talkStatus;
  TalkModel({
    this.talkId,
    this.userId,
    this.talkContent,
    this.talkImages,
    this.createTime,
    this.userImage,
    this.userName,
    this.talkLike,
    this.comment,
    this.talkStatus,
  });
  factory TalkModel.fromJson(Map<String, dynamic> json) {
    Map encodeContent = jsonDecode(json['talk_content']);
    return TalkModel(
      talkId: json['talk_id'] as int,
      userId: json['user_id'] as int,
      talkContent: encodeContent['content'] as String,
      talkImages: encodeContent['images'].cast<String>() as List<String>,
      createTime: json['create_time'] as String,
      userImage: json['user_image'] as String,
      userName: json['user_name'] as String,
      talkLike: Like.fromJson(json['like']),
      comment: json['comment'] as int,
      talkStatus: json['talk_status'] as int,
    );
  }
}

class Like extends Object {
  int count;
  bool action;
  Like({this.count, this.action});
  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      count: json['count'] as int,
      action: json['action'] as bool,
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'action': action,
      'count': count,
    };
  }
}
