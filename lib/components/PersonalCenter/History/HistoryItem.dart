import 'package:flutter/material.dart';
import 'package:yanyou/models/History.dart';

class HistoryItem extends StatelessWidget {
  final HistoryModel historyModel;
  HistoryItem({Key key, this.historyModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '浏览记录：',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8, left: 30),
            child: Text(
              '您在${historyModel.createTime}${historyModel.historyContent}',
            ),
          ),
        ],
      ),
    );
  }
}
