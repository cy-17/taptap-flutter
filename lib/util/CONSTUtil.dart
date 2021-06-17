import 'package:TapTap/pages/index/home/home_page.dart';
import 'package:TapTap/pages/index/home/recommend_page.dart';
import 'package:flutter/material.dart';

class CONSTUtil {
  static final Map<String, String> bottomNames = {
    'home': "首页",
    "discover": "发现",
    "dynamicState": "动态",
    "message": "消息",
    "mygame": "我的游戏"
  };
  static final List pageList = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage()
  ];
  static final List<Tab> tabs = [
    Tab(
      text: '推荐',
    ),
    Tab(
      text: '即将上线',
    ),
    Tab(
      text: '排行榜',
    ),
    Tab(
      text: '视频',
    ),
  ];

  static List<Widget> tabContent = [
    RecommendPage(),
    RecommendPage(),
    RecommendPage(),
    RecommendPage(),
  ];
}
