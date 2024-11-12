import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:yanyou/pages/College/CollegeDetails.dart';
import 'package:yanyou/pages/College/CollegeDetails/Admissions.dart';
import 'package:yanyou/pages/College/CollegeDetails/Experience.dart';
import 'package:yanyou/pages/College/CollegeDetails/GraduateCollege.dart';
import 'package:yanyou/pages/College/CollegeDetails/ReportRatio.dart';
import 'package:yanyou/pages/College/CollegeDetails/Resources.dart';
import 'package:yanyou/pages/College/CollegeDetails/ScoreLine.dart';
import 'package:yanyou/pages/College/CollegeDetails/Senior.dart';
import 'package:yanyou/pages/College/CollegeDetails/Totor.dart';
import 'package:yanyou/pages/College/CollegeDetails/Transfer.dart';
import 'package:yanyou/pages/Home/AdvisoryDetails.dart';
import 'package:yanyou/pages/Home/CheckPage.dart';
import 'package:yanyou/pages/Home/Micro/FindSenior.dart';
import 'package:yanyou/pages/Home/Micro/MonthPlan.dart';
import 'package:yanyou/pages/Home/Micro/FindResource.dart';
import 'package:yanyou/pages/Home/Micro/SchoolMeet/MeetDetails.dart';
import 'package:yanyou/pages/Home/Micro/SchoolMeet/SchoolMeet.dart';
import 'package:yanyou/pages/Home/RewardPage.dart';
import 'package:yanyou/pages/MessageCircle/ReleaseMessage.dart';
import 'package:yanyou/pages/PersonalCenter/Login/EmailCheck.dart';
import 'package:yanyou/pages/PersonalCenter/Login/Login.dart';
import 'package:yanyou/pages/PersonalCenter/Login/RegisterUser.dart';
import 'package:yanyou/pages/PersonalCenter/Login/ResetPassword.dart';
import 'package:yanyou/pages/PersonalCenter/PersonalItem/History.dart';
import 'package:yanyou/pages/PersonalCenter/PersonalItem/Message.dart';
import 'package:yanyou/pages/PersonalCenter/PersonalItem/ReleaseList.dart';
import 'package:yanyou/pages/PersonalCenter/PersonalItem/Setup.dart';
import 'package:yanyou/pages/index.dart';

// 主页
Handler rootHandler = Handler(
  handlerFunc: (BuildContext context, Map params) {
    return Index();
  },
);
// 打卡
Handler checkHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return CheckPage();
  },
);
// 月计划
Handler monthPlanHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return MonthPlan();
  },
);
// 找资料
Handler findResourceHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return FindResource();
  },
);
// 校研会
Handler schoolMeetHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return SchoolMeet();
  },
);
// 校研会会议详情
Handler meetDetailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    int id = int.parse(params['meetId'][0]);
    return MeetDetails(meetId: id);
  },
);
// 找学长
Handler findSeniorHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return FindSenior();
  },
);

// 发布消息
Handler releaseMessageHander = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return ReleaseMessage();
  },
);

// 热点详情
Handler advisoryDetailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    print(params);
    int id = int.parse(params['advisoryId'][0]);
    return AdvisoryDetails(advisoryId: id);
  },
);

// 扫码支付页面
Handler rewardPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    print(params);
    return RewardPage(type: params['type'][0]);
  },
);

// 院校详情
Handler collegeDetailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    int collegeId = int.parse(params['collegeId'][0]);
    return CollegeDetails(collegeId: collegeId);
  },
);

// 院校详情页中各项页面
// 研究生院
Handler collegeDetailsGraduateCollegeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return GraduateCollege();
  },
);
// 报录比
Handler collegeDetailsReportRatioHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return ReportRatio();
  },
);
// 考研经验
Handler collegeDetailsExperienceHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return Experience();
  },
);
// 直通学长
Handler collegeDetailsSeniorHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return Senior();
  },
);

// 研究生导师
Handler collegeDetailsTotorHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return Totor();
  },
);

// 真题资料
Handler collegeDetailsResourcesHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return Resources();
  },
);

// 招生简章
Handler collegeDetailsAdmissonsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return Admissions();
  },
);
// 历年分数线
Handler collegeDetailsScoreLineHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return ScoreLine();
  },
);
// 考研调剂
Handler collegeDetailsTransferHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return Transfer();
  },
);

// 个人中心各项路由
// 我的消息
Handler personalMessageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return Message();
  },
);
// 我发布的
Handler personalReleaseListHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return ReleaseList();
  },
);
// 浏览记录
Handler personalHistoryHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return History();
  },
);
// 设置
Handler personalSetupHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return Setup();
  },
);

// 用户认证相关
// 登录
Handler loginHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    return Login();
  },
);
// 邮箱验证
Handler emailCheckHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    String type = params['type'][0];
    return EmailCheck(type: type);
  },
);
// 注册
Handler registerUserHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    print(params);
    String userEmail = params['userEmail'][0];
    return RegisterUser(userEmail: userEmail);
  },
);
// 重置密码
Handler resetPasswordHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
    int userId = int.parse(params['userId'][0]);
    return ResetPassword(userId: userId);
  },
);
