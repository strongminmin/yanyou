import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/api/Talk.dart';
import 'package:yanyou/components/MessageCircle/MessageItem.dart';
import 'package:yanyou/models/Talk.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/TalkProvider.dart';
import 'package:yanyou/provider/UserProvider.dart';
import 'package:yanyou/routes/Application.dart';
import 'package:yanyou/routes/Routes.dart';

class MessageCircle extends StatefulWidget {
  _MessageCircleState createState() => _MessageCircleState();
}

class _MessageCircleState extends State<MessageCircle> {
  int page = 1;
  int count = 10;
  void jumpReleaseMessagePage() {
    Application.router.navigateTo(
      context,
      Routes.releaseMessagePage,
      transition: TransitionType.native,
    );
  }

  @override
  void initState() {
    super.initState();
    fetchRequest('refresh', page++, count);
  }

  Future<void> fetchRequest(String type, int page, int count) async {
    try {
      UserModel userModel = Provider.of<UserProvider>(
        context,
        listen: false,
      ).userInfo;
      TalkProvider talkProvider = Provider.of<TalkProvider>(
        context,
        listen: false,
      );
      var result = await getTalkList(
        userId: userModel.userId,
        page: page,
        count: count,
      );
      if (result['noerr'] == 0) {
        if (type == 'refresh') {
          talkProvider.initTalkModel('all', result['data']);
        } else {
          talkProvider.addTalkModel('all', result['data']);
        }
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> onLoadHandler() async {
    await fetchRequest('load', page++, count);
  }

  Future<void> onRefreshHanlder() async {
    page = 1;
    await fetchRequest('refresh', page++, count);
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    num screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('坛子'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: jumpReleaseMessagePage,
              icon: Icon(Icons.send),
            ),
          )
        ],
      ),
      body: Consumer<TalkProvider>(
        builder: (context, talkProvider, child) {
          List<TalkModel> talksModel = talkProvider.talksModel;
          return talksModel == null
              ? Center(child: CircularProgressIndicator())
              : Container(
                  width: screenWidth,
                  height: screenHeight,
                  color: Colors.white,
                  child: EasyRefresh(
                    onLoad: onLoadHandler,
                    onRefresh: onRefreshHanlder,
                    footer: MaterialFooter(),
                    header: MaterialHeader(),
                    child: ListView.builder(
                      itemCount: talksModel.length,
                      itemBuilder: (context, index) {
                        return MessageItem(
                          talkModel: talksModel[index],
                          type: 'all',
                        );
                      },
                    ),
                  ),
                );
        },
      ),
    );
  }
}
