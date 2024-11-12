import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:yanyou/api/Plan.dart';
import 'package:yanyou/components/Micro/MonthPlan/PlanItem.dart';
import 'package:yanyou/models/PlanModel.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/UserProvider.dart';

class MonthPlan extends StatefulWidget {
  MonthPlan({Key key}) : super(key: key);
  _MonthPlanState createState() => _MonthPlanState();
}

class _MonthPlanState extends State<MonthPlan>
    with SingleTickerProviderStateMixin {
  Map tabs = {
    '1': '一月',
    '2': '二月',
    '3': '三月',
    '4': '四月',
    '5': '五月',
    '6': '六月',
    '7': '七月',
    '8': '八月',
    '9': '九月',
    '10': '十月',
    '11': '十一月',
    '12': '十二月',
  };
  PlanModel planData;
  TabController _tabController;
  TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _textEditingController = TextEditingController();
    fetchRequest();
  }

  Future<void> fetchRequest() async {
    try {
      UserModel userModel = Provider.of<UserProvider>(
        context,
        listen: false,
      ).userInfo;
      var result = await getMonthPlan(userId: userModel.userId);
      if (result['noerr'] == 0) {
        setState(() {
          planData = PlanModel.fromJson(result['data']);
        });
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> releasePlanCallback() async {
    try {
      String content = _textEditingController.text;
      int month = _tabController.index + 1;
      if (content.isEmpty) {
        Toast.show(
          '内容不能为空',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
      }
      UserModel userModel = Provider.of<UserProvider>(
        context,
        listen: false,
      ).userInfo;
      var result = await releasePlan(
        userId: userModel.userId,
        month: month,
        content: content,
      );
      if (result['noerr'] == 0) {
        Navigator.of(context).pop();
        await fetchRequest();
        _textEditingController.clear();
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

  void showReleasePlanWidget() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        num screenWidth = MediaQuery.of(context).size.width;
        return Scaffold(
          body: Container(
            width: screenWidth,
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _textEditingController,
                    maxLines: 6,
                    maxLength: 100,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: '发布你的计划',
                      hintStyle: TextStyle(fontSize: 14),
                      border: InputBorder.none,
                    ),
                  ),
                  GestureDetector(
                    onTap: releasePlanCallback,
                    child: Container(
                      width: 180,
                      height: 42,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          '发布',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('月计划'),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: showReleasePlanWidget,
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Image.asset(
                'assets/images/jh.png',
                width: 28,
                height: 28,
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: tabs.keys
              .map(
                (item) => Container(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    tabs[item],
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      body: planData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : TabBarView(
              controller: _tabController,
              children: tabs.keys.map((item) {
                List<Plan> planInfos = planData.planModel[item];
                return Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.grey[200],
                  child: planInfos == null
                      ? Center(
                          child: Text(
                            '本月还未发布计划',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: planInfos.length,
                          itemBuilder: (context, index) {
                            return PlanItem(
                              planInfo: planInfos[index],
                              refreshCallback: fetchRequest,
                            );
                          },
                        ),
                );
              }).toList(),
            ),
    );
  }
}
