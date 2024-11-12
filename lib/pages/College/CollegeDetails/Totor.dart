import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/provider/CollegeProvider.dart';

class Totor extends StatefulWidget {
  final String collegeName;
  Totor({Key key, this.collegeName}) : super(key: key);
  _TotorState createState() => _TotorState();
}

class _TotorState extends State<Totor> {
  List<Map> totorsInfo = [
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
    {'name': '王老师', 'number': '15036889002'},
  ];
  List<Widget> childrenWidget = [];
  @override
  void initState() {
    super.initState();

    fetchRequest();
  }

  Future<void> fetchRequest() async {}

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    childrenWidget.add(titleWidget(screenWidth));

    return Scaffold(
      appBar: AppBar(
        title: Text('研究生导师'),
        centerTitle: true,
      ),
      body: Consumer<CollegeProvider>(
        builder: (context, collegeProvider, child) {
          List totorsInfo =
              collegeProvider.collegeDetailsModel.collegeGraduate['tutors'];
          childrenWidget.addAll(contentWidget(screenWidth, totorsInfo));
          return Container(
            width: screenWidth,
            padding: EdgeInsets.only(bottom: 16),
            child: SingleChildScrollView(
              child: Column(
                children: childrenWidget,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget titleWidget(num screenWidth) {
    TextStyle titleStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: screenWidth / 2,
            child: Center(child: Text('姓名', style: titleStyle)),
          ),
          Container(
            width: screenWidth / 2,
            child: Center(child: Text('联系方式', style: titleStyle)),
          ),
        ],
      ),
    );
  }

  List<Widget> contentWidget(num screenWidth, List totorsInfo) {
    List<Widget> totorsWidget = totorsInfo.map((totor) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.grey[200]),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: screenWidth / 2,
              child: Center(child: Text(totor[0])),
            ),
            Container(
              width: screenWidth / 2,
              child: Center(child: Text(totor[1])),
            ),
          ],
        ),
      );
    }).toList();
    return totorsWidget;
  }
}
