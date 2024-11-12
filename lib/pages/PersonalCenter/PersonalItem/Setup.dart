import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/components/PersonalCenter/Setup/Birthday.dart';
import 'package:yanyou/components/PersonalCenter/Setup/Description.dart';
import 'package:yanyou/components/PersonalCenter/Setup/Email.dart';
import 'package:yanyou/components/PersonalCenter/Setup/HanderImage.dart';
import 'package:yanyou/components/PersonalCenter/Setup/Logout.dart';
import 'package:yanyou/components/PersonalCenter/Setup/Name.dart';
import 'package:yanyou/components/PersonalCenter/Setup/Passwrod.dart';
import 'package:yanyou/components/PersonalCenter/Setup/Profession.dart';
import 'package:yanyou/components/PersonalCenter/Setup/School.dart';
import 'package:yanyou/components/PersonalCenter/Setup/Sex.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/UserProvider.dart';

class Setup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
        centerTitle: true,
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          UserModel userModel = userProvider.userInfo;
          return userModel.userId == 0
              ? Container()
              : Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.only(top: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        HeaderImage(userModel: userModel),
                        tagWidget('基本信息：'),
                        Name(userModel: userModel),
                        Email(userModel: userModel),
                        Password(userModel: userModel),
                        Sex(userModel: userModel),
                        Birthday(userModel: userModel),
                        Description(userModel: userModel),
                        tagWidget('报考信息：'),
                        School(userModel: userModel),
                        Profession(userModel: userModel),
                        Logout(),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

  Widget tagWidget(String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: <Widget>[
          Container(
            width: 4,
            height: 18,
            margin: EdgeInsets.only(top: 2, right: 4),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
