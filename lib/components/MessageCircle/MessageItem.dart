import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:yanyou/api/Talk.dart';
import 'package:yanyou/components/MessageCircle/CommentList.dart';
import 'package:yanyou/models/Talk.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/TalkProvider.dart';
import 'package:yanyou/provider/UserProvider.dart';
import 'package:yanyou/routes/Application.dart';
import 'package:yanyou/routes/Routes.dart';

class MessageItem extends StatelessWidget {
  final TalkModel talkModel;
  final String type;
  MessageItem({Key key, this.talkModel, this.type}) : super(key: key);
  final GlobalKey containerKey = GlobalKey();
  Function supportHander(BuildContext context) {
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
        }
        TalkProvider talkProvider = Provider.of<TalkProvider>(
          context,
          listen: false,
        );
        var result = await talkLike(
          userId: userModel.userId,
          targetId: talkModel.talkId,
          type: 0,
        );
        if (result['noerr'] == 0) {
          talkProvider.updateLike(type, talkModel.talkId, result['data']);
        }
      } catch (err) {
        print(err);
      }
    };
  }

  Function openCommentSheet(BuildContext context) {
    return () {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return CommentList(
            talkId: talkModel.talkId,
            type: type,
          );
        },
      );
    };
  }

  Function showdeleteTalkCallback(BuildContext context) {
    return () {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.INFO,
          animType: AnimType.BOTTOMSLIDE,
          tittle: '是否要删除这条心情？',
          desc: '',
          btnCancelOnPress: () {},
          btnOkOnPress: () async {
            await deleteTalkCallback(context);
          }).show();
    };
  }

  Future<void> deleteTalkCallback(BuildContext context) async {
    try {
      TalkProvider talkProvider = Provider.of<TalkProvider>(
        context,
        listen: false,
      );
      var result = await deleteTalk(
        talkId: talkModel.talkId,
      );
      if (result['noerr'] == 0) {
        talkProvider.deleteTalk(talkModel.talkId);
      }
      Toast.show(
        result['message'],
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
      );
      return;
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    num screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
              width: 0.5,
              color: Colors.grey[200],
            )),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              messageHeader(),
              messageContent(screenWidth),
              messageFooter(),
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: talkModel.talkStatus == 0
              ? Container()
              : Container(
                  width: screenWidth,
                  height: screenHeight,
                  color: Color.fromARGB(50, 0, 0, 0),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 10,
                        left: 40,
                        child: Text(
                          '该心情被禁用，请联系管理员查看相关情况。',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )),
        )
      ],
    );
  }

  // 消息的头部信息-头像及用户名称
  Widget messageHeader() {
    return Builder(
      builder: (BuildContext context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipOval(
                  child: CachedNetworkImage(
                    width: 40,
                    height: 40,
                    imageUrl: talkModel.userImage,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        talkModel.userName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        talkModel.createTime,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            type == 'all'
                ? Container()
                : GestureDetector(
                    onTap: showdeleteTalkCallback(context),
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }

  // 消息的内容区域-文字和图片
  Widget messageContent(num screenWidth) {
    num imageW = computeImageSize(screenWidth);
    List<Widget> imageWidgets = talkModel.talkImages.map((url) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          width: imageW,
          height: imageW,
          fit: BoxFit.cover,
          imageUrl: url,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      );
    }).toList();
    return Container(
      margin: EdgeInsets.only(left: 40, top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            talkModel.talkContent,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 8),
              child: Wrap(
                spacing: 4.0,
                runSpacing: 4.0,
                children: imageWidgets,
              ))
          // imageLayout(screenWidth)
        ],
      ),
    );
  }

  // 消息的底部信息-点赞及评论
  Widget messageFooter() {
    return Builder(
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(top: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: openCommentSheet(context),
                    child: Icon(
                      Icons.chat,
                      size: 20,
                      color: Colors.grey[400],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 2),
                    child: Text(
                      talkModel.comment.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: supportHander(context),
                    child: Icon(
                      Icons.thumb_up,
                      size: 20,
                      color: talkModel.talkLike.action
                          ? Colors.blue[400]
                          : Colors.grey[400],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 2),
                    child: Text(
                      talkModel.talkLike.count.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  //响应式计���图片的大小
  num computeImageSize(num screenWidth) {
    num width;
    if (talkModel.talkImages.length == 1) {
      width = (screenWidth / 2).floorToDouble() - 50;
    } else if (talkModel.talkImages.length <= 4) {
      width = (screenWidth / 2).floorToDouble() - 50;
    } else {
      width = (screenWidth / 3).floorToDouble() - 50;
    }
    return width;
  }
}
