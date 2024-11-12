import 'package:flutter/material.dart';

class FindSenior extends StatefulWidget {
  FindSenior({Key key}) : super(key: key);
  _FindSeniorState createState() => _FindSeniorState();
}

class _FindSeniorState extends State<FindSenior> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('找学长'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text('该功能暂未开通'),
        ),
      ),
    );
  }
}
