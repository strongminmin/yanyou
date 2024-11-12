import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toast/toast.dart';
import 'package:yanyou/api/Check.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/UserProvider.dart';

class CheckPage extends StatefulWidget {
  CheckPage({Key key}) : super(key: key);
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  CalendarController _calendarController;
  Map<DateTime, List> checkedDay = {};
  DateTime _selectDay = DateTime.now();
  bool loading = true;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    fetchRequest();
  }

  @override
  void dispose() {
    super.dispose();
    _calendarController.dispose();
  }

  void daySelectedHandler(DateTime dateTime, list) {
    setState(() {
      _selectDay = dateTime;
    });
  }

  Future<void> fetchRequest() async {
    try {
      UserModel userModel = Provider.of<UserProvider>(
        context,
        listen: false,
      ).userInfo;
      var result = await getCheckList(userId: userModel.userId);
      if (result['noerr'] == 0) {
        Map<DateTime, List> tempCheck = {};
        result['data'].forEach((item) {
          DateTime dateTime = DateTime(
            item['year'],
            item['month'],
            item['day'],
          );
          tempCheck[dateTime] = [];
        });
        setState(() {
          checkedDay = tempCheck;
          loading = false;
        });
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> checkAction() async {
    try {
      UserModel userModel = Provider.of<UserProvider>(
        context,
        listen: false,
      ).userInfo;
      var result = await checkIn(userId: userModel.userId);
      if (result['noerr'] == 0) {
        setState(() {
          checkedDay[DateTime.now()] = [];
        });
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('打卡'),
        centerTitle: true,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Column(
                children: <Widget>[
                  calendarWidget(),
                  ckeckContainer(),
                ],
              ),
            ),
    );
  }

  Widget calendarWidget() {
    return TableCalendar(
      locale: 'zh_CN',
      calendarController: _calendarController,
      endDay: DateTime.now(),
      holidays: checkedDay,
      calendarStyle: CalendarStyle(
        weekendStyle: TextStyle(color: Colors.black),
        holidayStyle: TextStyle(color: Colors.blue),
        selectedColor: Colors.blue[400],
        todayColor: Colors.blue[200],
        markersColor: Colors.blue[700],
        outsideDaysVisible: false,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        holidayDayBuilder: (context, date, _) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(50, 123, 123, 255),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  date.day.toString(),
                ),
              ),
            ),
          );
        },
        selectedDayBuilder: (context, date, _) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[400],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          );
        },
      ),
      onDaySelected: daySelectedHandler,
    );
  }

  Widget ckeckContainer() {
    bool checkDay = false;
    DateTime today = DateTime.now();
    int todayYear = today.year;
    int todayMonth = today.month;
    int todayDay = today.day;
    int originYear = _selectDay.year;
    int originMonth = _selectDay.month;
    int originDay = _selectDay.day;
    checkedDay.keys.forEach((key) {
      int targetYear = key.year;
      int targetMonth = key.month;
      int targetDay = key.day;

      if (targetYear == originYear &&
          targetMonth == originMonth &&
          targetDay == originDay) {
        checkDay = true;
      }
    });
    Color bgColor = Colors.grey[400];
    String text = '未打卡';
    if (checkDay) {
      text = '已打卡，请继续保持';
    } else if (todayYear == originYear &&
        todayMonth == originMonth &&
        todayDay == originDay) {
      bgColor = Colors.blue;
      text = '点击打卡';
    }
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: GestureDetector(
        onTap: () {
          if (text == '点击打卡') {
            checkAction();
          }
        },
        child: Container(
          width: 180,
          height: 50,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
