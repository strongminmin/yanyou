import 'package:flutter/material.dart';

class RewardPage extends StatelessWidget {
  final String type;
  RewardPage({Key key, this.type}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String url;
    String title;
    if (type == 'alipay') {
      url = 'assets/images/alipay-page.jpg';
      title = '支付宝支付';
    } else {
      url = 'assets/images/wechat-page.jpg';
      title = '微信支付';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Image.asset(url),
    );
  }
}
