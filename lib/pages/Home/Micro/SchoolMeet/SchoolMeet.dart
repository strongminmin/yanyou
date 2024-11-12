import 'package:flutter/material.dart';
import 'package:yanyou/api/Meet.dart';
import 'package:yanyou/components/Micro/SchoolMeet/MeetItem.dart';
import 'package:yanyou/models/Meet.dart';

class SchoolMeet extends StatefulWidget {
  SchoolMeet({Key key}) : super(key: key);
  _SchoolMeetState createState() => _SchoolMeetState();
}

class _SchoolMeetState extends State<SchoolMeet> {
  List<MeetModel> meetModelList;
  @override
  void initState() {
    super.initState();
    fetchRequest();
  }

  Future<void> fetchRequest() async {
    try {
      var result = await getMeetList();
      if (result['noerr'] == 0) {
        setState(() {
          meetModelList = result['data']
              .map((item) {
                return MeetModel.fromJson(item);
              })
              .cast<MeetModel>()
              .toList();
        });
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('校研会'),
        centerTitle: true,
      ),
      body: Container(
        width: screenWidth,
        padding: EdgeInsets.all(16),
        color: Colors.grey[200],
        child: meetModelList == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: meetModelList.length,
                itemBuilder: (context, index) {
                  return MeetItem(meetModel: meetModelList[index]);
                },
              ),
      ),
    );
  }
}
