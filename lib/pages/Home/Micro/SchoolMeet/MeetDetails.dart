import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/api/Meet.dart';
import 'package:yanyou/models/Meet.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/UserProvider.dart';

class MeetDetails extends StatefulWidget {
  final int meetId;
  MeetDetails({Key key, this.meetId}) : super(key: key);
  _MeetDetailsState createState() => _MeetDetailsState();
}

class _MeetDetailsState extends State<MeetDetails> {
  MeetModel meetModel;
  @override
  void initState() {
    super.initState();
    fetchRequest();
  }

  Future<void> fetchRequest() async {
    try {
      UserModel userModel = Provider.of<UserProvider>(
        context,
        listen: false,
      ).userInfo;
      var result = await getMeetDetails(
        userId: userModel.userId,
        meetId: widget.meetId,
      );
      if (result['noerr'] == 0) {
        setState(() {
          meetModel = MeetModel.fromJson(result['data']);
        });
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    num screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('会议详情'),
        centerTitle: true,
      ),
      body: meetModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: screenWidth,
              height: screenHeight,
              padding: EdgeInsets.only(bottom: 16),
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  meetHander(screenWidth),
                  meetContent(screenWidth),
                ],
              ),
            ),
    );
  }

  Widget meetHander(num screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        meetTitle(),
        meetSub(),
      ],
    );
  }

  Widget meetTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(top: 8),
      child: Text(
        meetModel.meetTitle,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget meetSub() {
    TextStyle style = TextStyle(
      fontSize: 13,
      color: Colors.grey,
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('发布于${meetModel.createTime}', style: style),
          Text('${meetModel.meetAccess}人访问', style: style),
        ],
      ),
    );
  }

  Widget meetContent(num screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(top: 12),
      child: Html(data: meetModel.meetContent),
    );
  }
}
