import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/provider/CollegeProvider.dart';

class Admissions extends StatefulWidget {
  Admissions({Key key}) : super(key: key);
  _AdmissionsState createState() => _AdmissionsState();
}

class _AdmissionsState extends State<Admissions> {
  @override
  void initState() {
    super.initState();
    fetchRequest();
  }

  Future<void> fetchRequest() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('招生简章'),
        centerTitle: true,
      ),
      body: Consumer<CollegeProvider>(
        builder: (context, collegeProvider, child) {
          String content = collegeProvider.collegeDetailsModel.collegeIntor;
          return Container(
            padding: EdgeInsets.all(16),
            child: content == ''
                ? Center(
                    child: Text('信息未录入'),
                  )
                : Text(
                    content,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
