import 'package:flutter/material.dart';
import 'package:yanyou/pages/College/College.dart';
import 'package:yanyou/pages/Home/Home.dart';
import 'package:yanyou/pages/MessageCircle/MessageCircle.dart';
import 'package:yanyou/pages/PersonalCenter/PersonalCenter.dart';

List<Map> indexBottomBar = [
  {'icon': Icons.home, 'page': Home(), 'text': '首页'},
  {'icon': Icons.school, 'page': College(), 'text': '院校'},
  {'icon': Icons.stars, 'page': MessageCircle(), 'text': '坛子'},
  {'icon': Icons.person, 'page': PersonalCenter(), 'text': '我的'}
];
