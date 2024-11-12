import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/api/Talk.dart';
import 'package:yanyou/models/CommentModel.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/UserProvider.dart';
import 'package:yanyou/routes/Application.dart';
import 'package:yanyou/routes/Routes.dart';

class CommentItem extends StatelessWidget {
  final CommentModel commentModel;
  final Function likeCallback;
  CommentItem({Key key, this.commentModel, this.likeCallback}) : super();
  Function commentLikeAction(BuildContext context) {
    return () async {
      try {
        UserModel userModel = Provider.of<UserProvider>(
          context,
          listen: false,
        ).userInfo;
        if (userModel.userId == 0) {
          Application.router.navigateTo(
            context,
            Routes.loginPage,
            transition: TransitionType.native,
          );
          return;
        }
        var result = await talkLike(
          userId: userModel.userId,
          targetId: commentModel.commentId,
          type: 1,
        );
        if (result['noerr'] == 0) {
          likeCallback(commentModel.commentId, result['data']);
        }
      } catch (err) {
        print(err);
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipOval(
                child: CachedNetworkImage(
                  width: 35,
                  height: 35,
                  imageUrl: commentModel.userImage,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      commentModel.userName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      commentModel.createTime,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 40, top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: screenWidth - 110,
                  child: Text(
                    commentModel.commentContent,
                    maxLines: 3,
                  ),
                ),
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: commentLikeAction(context),
                      child: Icon(Icons.favorite,
                          color: commentModel.commentLike.action
                              ? Colors.red
                              : Colors.grey[400]),
                    ),
                    Text(
                      commentModel.commentLike.count.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
