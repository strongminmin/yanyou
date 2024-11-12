import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:yanyou/api/Plan.dart';
import 'package:yanyou/models/PlanModel.dart';

class PlanItem extends StatelessWidget {
  final Plan planInfo;
  final Function refreshCallback;
  PlanItem({Key key, this.refreshCallback, this.planInfo}) : super(key: key);

  Function removeMonthPlan(BuildContext context) {
    return () async {
      try {
        var result = await deletePlan(planId: planInfo.planId);
        if (result['noerr'] == 0) {
          await refreshCallback();
        }
        Toast.show(
          result['message'],
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
      } catch (err) {
        print(err);
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.only(left: 16, bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Text(
                    '发布于${planInfo.createTime}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Text(
                    planInfo.planContent,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: removeMonthPlan(context),
              child: Icon(
                Icons.clear,
                size: 22,
                color: Colors.grey[400],
              ),
            ),
          )
        ],
      ),
    );
  }
}
