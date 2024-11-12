import 'package:yanyou/models/Talk.dart';

class CommentModel extends Object {
  int commentId;
  int userId;
  int talkId;
  String commentContent;
  String createTime;
  String userName;
  String userImage;
  Like commentLike;
  CommentModel(
      {this.commentId,
      this.talkId,
      this.userId,
      this.userName,
      this.userImage,
      this.createTime,
      this.commentContent,
      this.commentLike});
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['comment_id'] as int,
      talkId: json['talk_id'] as int,
      userId: json['user_id'] as int,
      userName: json['user_name'] as String,
      userImage: json['user_image'] as String,
      createTime: json['create_time'] as String,
      commentContent: json['comment_content'] as String,
      commentLike: Like.fromJson(
        json['like'],
      ),
    );
  }
}
