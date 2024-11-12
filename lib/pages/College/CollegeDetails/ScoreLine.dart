import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/provider/CollegeProvider.dart';

class ScoreLine extends StatefulWidget {
  final String collegeName;
  ScoreLine({Key key, this.collegeName}) : super(key: key);
  _ScoreLineState createState() => _ScoreLineState();
}

class _ScoreLineState extends State<ScoreLine> {
  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('历年分数线'),
        centerTitle: true,
      ),
      body: Consumer<CollegeProvider>(
        builder: (context, collegeProvider, child) {
          List yearScoreLine =
              collegeProvider.collegeDetailsModel.collegeGraduate['sourceLine'];
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: scoreLineContent(screenWidth, yearScoreLine),
            ),
          );
        },
      ),
    );
  }

  List<Widget> scoreLineContent(num screenWidth, List yearScoreLine) {
    return yearScoreLine.map((scoreLine) {
      return Container(
        width: screenWidth,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.grey[200]),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              scoreLine[0],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '年初始分数线：',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '${scoreLine[1]}分',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
