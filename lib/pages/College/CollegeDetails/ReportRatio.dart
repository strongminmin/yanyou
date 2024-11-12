import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/provider/CollegeProvider.dart';

class ReportRatio extends StatefulWidget {
  final String collegeName;
  ReportRatio({Key key, this.collegeName}) : super(key: key);
  _ReportRatioState createState() => _ReportRatioState();
}

class _ReportRatioState extends State<ReportRatio> {
  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('报录比'),
        centerTitle: true,
      ),
      body: Consumer<CollegeProvider>(
        builder: (context, collegeProvider, child) {
          List ratios = collegeProvider
              .collegeDetailsModel.collegeGraduate['reportRatio'];
          return Container(
            width: screenWidth,
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: ratioContent(screenWidth, ratios),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> ratioContent(num screenWidth, List ratios) {
    return ratios.map((ratio) {
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
              ratio[0],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '年报录比',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              ratio[1],
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
