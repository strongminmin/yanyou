import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  Message({Key key}) : super(key: key);
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的消息'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
