import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toast/toast.dart';
import 'package:yanyou/provider/CollegeProvider.dart';

class Senior extends StatefulWidget {
  final String collegeName;
  Senior({Key key, this.collegeName}) : super(key: key);
  _SeniorState createState() => _SeniorState();
}

class _SeniorState extends State<Senior> {
  Function addFriend(String number) {
    return () async {
      try {
        String url = 'weixin://';
        if (!await canLaunch(url)) {
          Toast.show(
            '微信未安装',
            context,
            duration: Toast.LENGTH_LONG,
          );
          return;
        }
        var result = await launch(url);
        if (!result) {
          Toast.show(
            '打开微信失败',
            context,
            duration: Toast.LENGTH_LONG,
          );
        }
      } on PlatformException catch (err) {
        print(err);
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('直通学长'),
        centerTitle: true,
      ),
      body: Consumer<CollegeProvider>(
        builder: (context, collegeProvider, child) {
          List seniorInfo =
              collegeProvider.collegeDetailsModel.collegeGraduate['seniors'];
          return Container(
            width: screenWidth,
            padding: EdgeInsets.all(16),
            child: Column(
              children: seniorWidget(screenWidth, seniorInfo),
            ),
          );
        },
      ),
    );
  }

  List<Widget> seniorWidget(num screenWidth, List seniorInfo) {
    return seniorInfo.map((senior) {
      return Container(
        width: screenWidth,
        padding: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.grey[200]),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              senior[0],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '微信:${senior[1]}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: addFriend(senior[1]),
              child: Container(
                width: 80,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(
                    '添加好友',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
