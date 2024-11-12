import 'package:flutter/material.dart';
import 'package:yanyou/components/PersonalCenter/Content.dart';
import 'package:yanyou/components/PersonalCenter/Header.dart';

class PersonalCenter extends StatefulWidget {
  _PersonalCenterState createState() => _PersonalCenterState();
}

class _PersonalCenterState extends State<PersonalCenter> {
  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    num screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[100],
        width: screenWidth,
        height: screenHeight,
        child: Column(
          children: <Widget>[
            Header(),
            Content(),
          ],
        ),
      ),
    );
  }
}
