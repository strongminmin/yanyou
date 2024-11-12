import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yanyou/api/Advisory.dart';
import 'package:yanyou/api/Banner.dart';
import 'package:yanyou/api/Check.dart';
import 'package:yanyou/components/Home/AdvisoryItem.dart';
import 'package:yanyou/components/Home/BannerSwiper.dart';
import 'package:yanyou/components/Home/CheckIn.dart';
import 'package:yanyou/components/Home/MicroPage.dart';
import 'package:yanyou/models/AdvisoryModel.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/UserProvider.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> bannersUrl = [];
  List<AdvisoryModel> advisoryList = [];
  bool loading = true;
  int page = 1;
  int count = 10;
  bool checked = false;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    cacheToUser();
    requestBanner();
    requestAdvisoryList('refresh', page++, count);
    requestCheck();
  }

  // 用户是否打卡请求
  Future<void> requestCheck() async {
    try {
      UserModel userModel = Provider.of<UserProvider>(
        context,
        listen: false,
      ).userInfo;
      var result = await getUserChecked(userId: userModel.userId);
      if (result['noerr'] == 0) {
        setState(() {
          checked = result['data'];
        });
      }
    } catch (err) {
      print(err);
    }
  }

  // 本地缓存中获取用户
  Future<void> cacheToUser() async {
    UserProvider userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    SharedPreferences prefs = await _prefs;
    String userInfoJson = prefs.getString('user');
    if (userInfoJson != null) {
      Map userInfo = jsonDecode(userInfoJson);
      await userProvider.updateUserInfo(userInfo);
    }
  }

  // 轮播图请求
  Future<void> requestBanner() async {
    try {
      var result = await getBannerList();
      if (result['noerr'] == 0) {
        List<String> tempBannersUrl = result['data']
            .map((item) {
              return item['banner_url'];
            })
            .cast<String>()
            .toList();
        setState(() {
          bannersUrl = tempBannersUrl;
          loading = false;
        });
      }
    } catch (err) {
      print(err);
    }
  }

  // 热点列表请求
  Future<void> requestAdvisoryList(String type, int page, int count) async {
    try {
      var result = await getAdvisoryList(page: page, count: count);
      if (result['noerr'] == 0) {
        List<AdvisoryModel> tempAdvisoryList = result['data']
            .map((item) {
              return AdvisoryModel.fromJson(item);
            })
            .cast<AdvisoryModel>()
            .toList();
        setState(() {
          if (type == 'refresh') {
            advisoryList = tempAdvisoryList;
          } else {
            advisoryList.addAll(tempAdvisoryList);
          }
        });
      }
    } catch (err) {
      print(err);
    }
  }

  // 上拉加载
  Future<void> onLoadHandler() async {
    await requestAdvisoryList('load', page++, count);
  }

  // 下拉刷新
  Future<void> onRefreshHandler() async {
    page = 1;
    await requestAdvisoryList('refresh', page++, count);
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    List<Widget> widgetsList = initialHeaderWidgets(screenWidth);
    List<Widget> advisoryWidget = advisoryList.map((item) {
      return AdvisoryItem(advisory: item);
    }).toList();
    widgetsList.addAll(advisoryWidget);
    return Scaffold(
      appBar: AppBar(
        title: Text('研优'),
        centerTitle: true,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: screenWidth,
              color: Colors.white,
              child: EasyRefresh(
                onLoad: onLoadHandler,
                onRefresh: onRefreshHandler,
                footer: MaterialFooter(),
                header: MaterialHeader(),
                child: ListView(
                  children: widgetsList,
                ),
              ),
            ),
    );
  }

  List<Widget> initialHeaderWidgets(screenWidth) {
    return <Widget>[
      CheckIn(checked: checked),
      BannerSwiper(bannersUrl: bannersUrl),
      MicroPage(),
      Container(
        width: screenWidth,
        height: 0.5,
        margin: EdgeInsets.symmetric(vertical: 12),
        color: Colors.grey[200],
      ),
      hotTitle(),
    ];
  }

  Widget hotTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 4,
            height: 20,
            margin: EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(2)),
          ),
          Text(
            '每日热点',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
