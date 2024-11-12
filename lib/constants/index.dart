import 'package:yanyou/routes/Routes.dart';

List<Map> microPage = [
  {
    'text': '月计划',
    'url': 'assets/images/jh.png',
    'page': Routes.monthPlanPage,
  },
  {
    'text': '找资料',
    'url': 'assets/images/ziyuan.png',
    'page': Routes.findResourcePage,
  },
  {
    'text': '校研会',
    'url': 'assets/images/huiyi.png',
    'page': Routes.schoolMeetPage,
  },
  {
    'text': '找学长',
    'url': 'assets/images/xuesheng.png',
    'page': Routes.findSeniorPage,
  }
];

List<Map> collegeGrid = [
  {
    'text': '研究生院',
    'url': 'assets/images/xuexiao.png',
    'page': Routes.graduateCollegePage,
    'type': 'graduateUrl',
  },
  {
    'text': '报录比',
    'url': 'assets/images/bili.png',
    'page': Routes.reportRatioPage,
    'type': 'reportRatio',
  },
  {
    'text': '考研经验',
    'url': 'assets/images/jingyan.png',
    'page': Routes.experiencePage,
    'type': 'experience',
  },
  {
    'text': '直通学长',
    'url': 'assets/images/xuesheng.png',
    'page': Routes.seniorPage,
    'type': 'seniors',
  },
  {
    'text': '研究生导师',
    'url': 'assets/images/daoshi.png',
    'page': Routes.totorPage,
    'type': 'tutors',
  },
  {
    'text': '真题资料',
    'url': 'assets/images/ziyuan.png',
    'page': Routes.resourcesPage,
    'type': 'resources',
  },
  {
    'text': '招生简章',
    'url': 'assets/images/jianzhang.png',
    'page': Routes.admissionsPage,
    'type': 'intor',
  },
  {
    'text': '历年分数线',
    'url': 'assets/images/fenshuxian.png',
    'page': Routes.scoreLinePage,
    'type': 'sourceLine'
  },
  {
    'text': '考研调剂',
    'url': 'assets/images/tiaoji.png',
    'page': Routes.transferPage,
    'type': 'transferUrl'
  },
];

List<Map> personalCenterItems = [
  {
    'text': '我的消息',
    'image': 'assets/images/xiaoxi.png',
    'page': Routes.messagePage,
  },
  {
    'text': '我发布的',
    'image': 'assets/images/release.png',
    'page': Routes.releaseListPage,
  },
  {
    'text': '浏览记录',
    'image': 'assets/images/jilu.png',
    'page': Routes.historyPage,
  },
  {
    'text': '设置',
    'image': 'assets/images/setting.png',
    'page': Routes.setupPage,
  },
];
