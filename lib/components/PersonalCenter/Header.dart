import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/UserProvider.dart';
import 'package:yanyou/routes/Application.dart';
import 'package:yanyou/routes/Routes.dart';

class Header extends StatelessWidget {
  Header({Key key}) : super(key: key);
  Function jumpLoginPage(BuildContext context) {
    return () {
      Application.router.navigateTo(
        context,
        Routes.loginPage,
        transition: TransitionType.native,
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        UserModel userModel = userProvider.userInfo;
        return Container(
          height: 150,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 16, top: 16),
                height: 100,
                color: Colors.blue[400],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        width: 60,
                        height: 60,
                        imageUrl: userModel.userImage,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    userModel.userId == 0
                        ? GestureDetector(
                            onTap: jumpLoginPage(context),
                            child: Container(
                              margin: EdgeInsets.only(top: 12, left: 8),
                              child: Text(
                                '登录/注册',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(left: 8, top: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  userModel.userName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: screenWidth - 100,
                                  margin: EdgeInsets.only(top: 4),
                                  child: Text(
                                    userModel.userDescription,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[200],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
              Positioned(
                top: 85,
                left: screenWidth * 0.1,
                child: Container(
                  width: screenWidth * 0.8,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            '志愿学校：',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(userModel.volunteerSchool),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '报考专业：',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(userModel.volunteerProfession),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
