import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/constants/index.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/UserProvider.dart';
import 'package:yanyou/routes/Application.dart';
import 'package:yanyou/routes/Routes.dart';

class MicroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: microPage.map((micro) {
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
                  micro['page'],
                  transition: TransitionType.native,
                );
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(micro['url'], width: 36, height: 36),
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    micro['text'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
