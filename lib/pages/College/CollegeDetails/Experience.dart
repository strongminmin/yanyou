import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/provider/CollegeProvider.dart';

class Experience extends StatefulWidget {
  Experience({Key key}) : super(key: key);
  _ExperienceState createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
  List<Map> experiences = [
    {
      'Q': '考研应该怎么准备？考研应该怎么准备？考研应该怎么准备？考研应该怎么准备？考研应该怎么准备？',
      'A': '别学了，玩去吧。别学了，玩去吧。别学了，玩去吧。别学了，玩去吧。别学了，玩去吧。别学了，玩去吧。'
    },
    {'Q': '考研应该怎么准备？', 'A': '别学了，玩去吧。'},
    {'Q': '考研应该怎么准备？', 'A': '别学了，玩去吧。'},
    {'Q': '考研应该怎么准备？', 'A': '别学了，玩去吧。'},
    {'Q': '考研应该怎么准备？', 'A': '别学了，玩去吧。'},
    {'Q': '考研应该怎么准备？', 'A': '别学了，玩去吧。'},
    {'Q': '考研应该怎么准备？', 'A': '别学了，玩去吧。'},
    {'Q': '考研应该怎么准备？', 'A': '别学了，玩去吧。'},
    {'Q': '考研应该怎么准备？', 'A': '别学了，玩去吧。'},
  ];
  @override
  void initState() {
    super.initState();
  }

  List<Widget> experiencesWidget(num screenWidth, List experiences) {
    return experiences.map((exper) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.grey[200]),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Q：',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: screenWidth - 100,
                    margin: EdgeInsets.only(top: 2),
                    child: Text(
                      exper[0],
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'A：',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: screenWidth - 100,
                    margin: EdgeInsets.only(top: 2),
                    child: Text(
                      exper[1],
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    num screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('考研经验'),
        centerTitle: true,
      ),
      body: Consumer<CollegeProvider>(
        builder: (context, collegeProvider, child) {
          List experiences =
              collegeProvider.collegeDetailsModel.collegeGraduate['experience'];
          return Container(
            width: screenWidth,
            height: screenHeight,
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: experiencesWidget(screenWidth, experiences),
              ),
            ),
          );
        },
      ),
    );
  }
}
