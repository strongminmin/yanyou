import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/constants/index.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/UserProvider.dart';
import 'package:yanyou/routes/Application.dart';
import 'package:yanyou/routes/Routes.dart';

class Content extends StatelessWidget {
  Content({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        children: normalListWidget(),
      ),
    );
  }

  List<Widget> normalListWidget() {
    return personalCenterItems.map((item) {
      // bool isSystemMessage = item['text'] == '系统消息' && tips != 0 ? true : false;
      return Builder(builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
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
            } else {
              Application.router.navigateTo(
                context,
                item['page'],
                transition: TransitionType.native,
              );
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            margin: EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.grey[100]),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    item['image'],
                    width: 20,
                    height: 20,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    item['text'],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        );
      });
    }).toList();
  }
}
