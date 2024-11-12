import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:yanyou/api/Talk.dart';
import 'package:yanyou/components/MessageCircle/CommentItem.dart';
import 'package:yanyou/models/CommentModel.dart';
import 'package:yanyou/models/Talk.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/TalkProvider.dart';
import 'package:yanyou/provider/UserProvider.dart';
import 'package:yanyou/routes/Application.dart';
import 'package:yanyou/routes/Routes.dart';

class CommentList extends StatefulWidget {
  final int talkId;
  final String type;
  CommentList({Key key, this.talkId, this.type}) : super(key: key);
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  TextEditingController _textEditingController;
  int page = 1;
  int count = 10;
  List<CommentModel> commentsModel;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    fetchRequet('refresh', page++, count);
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController?.dispose();
  }

  Future<void> fetchRequet(String type, int page, int count) async {
    try {
      UserModel userModel = Provider.of<UserProvider>(
        context,
        listen: false,
      ).userInfo;
      var result = await getCommentList(
        userId: userModel.userId,
        targetId: widget.talkId,
        page: page,
        count: count,
      );
      if (result['noerr'] == 0) {
        List<CommentModel> tempModel = result['data']
            .map((item) {
              return CommentModel.fromJson(item);
            })
            .cast<CommentModel>()
            .toList();
        setState(() {
          if (type == 'refresh') {
            commentsModel = tempModel;
          } else {
            commentsModel.addAll(tempModel);
          }
        });
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> onLoadHandler() async {
    await fetchRequet('load', page++, count);
  }

  Future<void> onRefreshHandler() async {
    page = 1;
    await fetchRequet('refresh', page++, count);
  }

  Future<void> commentAction() async {
    try {
      TalkProvider talkProvider = Provider.of<TalkProvider>(
        context,
        listen: false,
      );
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
      String content = _textEditingController.text;
      if (content.isEmpty) {
        Toast.show(
          '内容不能为空',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
        return;
      }
      var result = await releaseComment(
        userId: userModel.userId,
        targetId: widget.talkId,
        commentContent: content,
      );
      if (result['noerr'] == 0) {
        page = 1;
        await fetchRequet('refresh', page++, count);
        talkProvider.updateComment(widget.type, widget.talkId, result['data']);
        _textEditingController.clear();
        FocusScope.of(context).requestFocus(FocusNode());
      }
    } catch (err) {
      print(err);
    }
  }

  void likeCallback(int commentId, Map<String, dynamic> json) {
    print(json);
    Like like = Like.fromJson(json);
    setState(() {
      commentsModel.forEach((model) {
        if (model.commentId == commentId) {
          model.commentLike = like;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: commentsModel == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: screenWidth,
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    '评论列表',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: commentsModel.isEmpty
                        ? Center(child: Text('该心情还没有评论。'))
                        : EasyRefresh(
                            onLoad: onLoadHandler,
                            onRefresh: onRefreshHandler,
                            footer: MaterialFooter(),
                            header: MaterialHeader(),
                            child: ListView.builder(
                              itemCount: commentsModel.length,
                              itemBuilder: (context, index) {
                                return CommentItem(
                                  commentModel: commentsModel[index],
                                  likeCallback: likeCallback,
                                );
                              },
                            ),
                          ),
                  ),
                  TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      suffix: GestureDetector(
                        onTap: commentAction,
                        child: Text(
                          '评论',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
