import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:yanyou/api/Advisory.dart';
import 'package:yanyou/routes/Application.dart';
import 'package:yanyou/routes/Routes.dart';

class Reward extends StatefulWidget {
  final int advisoryId;
  Reward({Key key, this.advisoryId}) : super(key: key);
  _RewardState createState() => _RewardState();
}

class _RewardState extends State<Reward> {
  Function callPay(String type) {
    return () async {
      advisoryReward(advisoryId: widget.advisoryId);
      Application.router.pop(context);
      if (type == 'alipay') {
        Application.router.navigateTo(
          context,
          '${Routes.rewardPage}?type=alipay',
          transition: TransitionType.native,
        );
      } else {
        Application.router.navigateTo(
          context,
          '${Routes.rewardPage}?type=wechat',
          transition: TransitionType.native,
        );
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 100,
      width: screenWidth,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            onTap: callPay('alipay'),
            child: Image.asset(
              'assets/images/alipay.png',
              width: 50,
              height: 50,
            ),
          ),
          GestureDetector(
            onTap: callPay('wechat'),
            child: Image.asset(
              'assets/images/wechat.png',
              width: 55,
              height: 55,
            ),
          ),
        ],
      ),
    );
  }
}
