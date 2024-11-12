import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/api/History.dart';
import 'package:yanyou/components/PersonalCenter/History/HistoryItem.dart';
import 'package:yanyou/models/History.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/UserProvider.dart';

class History extends StatefulWidget {
  History({Key key}) : super(key: key);
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<HistoryModel> historysModel;
  int count = 10;
  int page = 1;
  @override
  void initState() {
    super.initState();
    fetchRequest('refresh', page++, count);
  }

  Future<void> fetchRequest(String type, int page, int count) async {
    try {
      UserModel userModel = Provider.of<UserProvider>(
        context,
        listen: false,
      ).userInfo;
      var result = await getHistoryList(
        userId: userModel.userId,
        page: page,
        count: count,
      );
      if (result['noerr'] == 0) {
        List<HistoryModel> tempModel = result['data']
            .map((item) {
              return HistoryModel.fromJson(item);
            })
            .cast<HistoryModel>()
            .toList();
        setState(() {
          if (type == 'refresh') {
            historysModel = tempModel;
          } else {
            historysModel.addAll(tempModel);
          }
        });
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> onLoadHandler() async {
    await fetchRequest('load', page++, count);
  }

  Future<void> onRefreshHanlder() async {
    page = 1;
    await fetchRequest('refresh', page++, count);
  }

  void showCleanDialog() {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO,
        animType: AnimType.BOTTOMSLIDE,
        tittle: '确定要清空浏览记录吗？',
        desc: '',
        btnCancelOnPress: () {},
        btnOkOnPress: () async {
          await cleanHistoryCallback();
        }).show();
  }

  Future<void> cleanHistoryCallback() async {
    try {
      UserModel userModel = Provider.of<UserProvider>(
        context,
        listen: false,
      ).userInfo;
      var result = await cleanHistory(userId: userModel.userId);
      if (result['noerr'] == 0) {
        page = 1;
        await fetchRequest('refresh', page++, count);
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('浏览记录'),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: showCleanDialog,
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Icon(Icons.clear_all, size: 30),
            ),
          ),
        ],
      ),
      body: historysModel == null
          ? Center(child: CircularProgressIndicator())
          : historysModel.isEmpty
              ? Center(child: Text('您还没有浏览记录'))
              : Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.grey[100],
                  child: EasyRefresh(
                    onLoad: onLoadHandler,
                    onRefresh: onRefreshHanlder,
                    footer: MaterialFooter(),
                    header: MaterialHeader(),
                    child: ListView.builder(
                      itemCount: historysModel.length,
                      itemBuilder: (context, index) {
                        return HistoryItem(historyModel: historysModel[index]);
                      },
                    ),
                  ),
                ),
    );
  }
}
