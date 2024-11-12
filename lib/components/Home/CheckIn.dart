import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/UserProvider.dart';
import 'package:yanyou/routes/Application.dart';
import 'package:yanyou/routes/Routes.dart';

class CheckIn extends StatefulWidget {
  final bool checked;
  CheckIn({Key key, this.checked}) : super(key: key);
  _CheckInState createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  @override
  void initState() {
    super.initState();
    computeCountDown();
  }

  String _year = '';
  String _remainDay = '';
  void computeCountDown() {
    DateTime dateTime = DateTime.now();
    DateTime targetTime = DateTime(dateTime.year, 12, 23);
    DateTime nextTargetTime = DateTime(dateTime.year + 1, 12, 23);
    Duration diff = dateTime.difference(targetTime);
    int day = diff.inDays;
    if (day > 0) {
      Duration diffNextTarget = dateTime.difference(nextTargetTime);
      int nextTargetDay = diffNextTarget.inDays;
      _year = (dateTime.year + 2).toString();
      _remainDay = (-nextTargetDay).toString();
    } else {
      _remainDay = (-day).toString();
      _year = (dateTime.year + 1).toString();
    }
  }

  void jumpCheckPage() {
    UserModel userModel = Provider.of<UserProvider>(
      context,
      listen: false,
    ).userInfo;
    if (userModel.userId == 0) {
      Application.router.navigateTo(
        context,
        Routes.loginPage,
        transition: TransitionType.native,
      );
    } else {
      Application.router.navigateTo(
        context,
        '${Routes.checkPage}',
        transition: TransitionType.native,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$_year 届考研倒计时',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _remainDay,
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  Text('天')
                ],
              ),
              GestureDetector(
                onTap: jumpCheckPage,
                child: Container(
                  width: 70,
                  height: 30,
                  decoration: BoxDecoration(
                    color: widget.checked ? Colors.grey : Colors.blue[300],
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: Text(
                      widget.checked ? '已打卡' : '打卡',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
