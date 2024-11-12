import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:yanyou/models/Meet.dart';
import 'package:yanyou/routes/Application.dart';
import 'package:yanyou/routes/Routes.dart';

class MeetItem extends StatelessWidget {
  final MeetModel meetModel;
  MeetItem({Key key, this.meetModel}) : super(key: key);
  Function jumpMeetDetails(BuildContext context) {
    return () {
      Application.router.navigateTo(
        context,
        '${Routes.meetDetailsPage}?meetId=${meetModel.meetId}',
        transition: TransitionType.native,
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: jumpMeetDetails(context),
      child: Container(
        width: screenWidth,
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              meetModel.meetTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              child: Row(
                children: <Widget>[
                  Text(
                    '发布于${meetModel.createTime}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Text(
                      '${meetModel.meetAccess}访问量',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
