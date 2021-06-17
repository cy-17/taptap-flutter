import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/util/CONSTUtil.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: CONSTUtil.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _TitleTabBar(
          tabController: this._tabController,
        ),
      ),
      body: TabBarView(
        children: CONSTUtil.tabContent,
        controller: _tabController,
      ),
    );
  }
}

class _TitleTabBar extends StatefulWidget {
  final TabController tabController;

  _TitleTabBar({Key? key, required this.tabController}) : super(key: key);

  @override
  __TitleTabBarState createState() => __TitleTabBarState();
}

class __TitleTabBarState extends State<_TitleTabBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TabBar(
            unselectedLabelColor: Colors.grey, //设置未选中时的字体颜色，tabs里面的字体样式优先级最高
            unselectedLabelStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400), //设置未选中时的字体样式，tabs里面的字体样式优先级最高
            labelColor: Colors.black, //设置选中时的字体颜色，tabs里面的字体样式优先级最高
            labelStyle: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w700), //设置选中时的字体样式，tabs里面的字体样式优先级最高
            labelPadding: EdgeInsets.symmetric(horizontal: 16),

            indicatorColor: AppColors.navActive,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: CONSTUtil.tabs,
            isScrollable: true,
            controller: widget.tabController,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          width: 40,
          height: 40,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(horizontal: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              // 底色
              boxShadow: [
                BoxShadow(
                  blurRadius: 10, //阴影范围
                  spreadRadius: 4, //阴影浓度
                  color: Color(0xFFF7F7F7),
                ),
              ], borderRadius: BorderRadius.circular(19), color: Colors.white),
          child: Image.asset(
            "assets/images/home/search.png",
            width: 30,
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              // 底色
              boxShadow: [
                BoxShadow(
                  blurRadius: 10, //阴影范围
                  spreadRadius: 4, //阴影浓度
                  color: Color(0xFFF7F7F7),
                ),
              ], borderRadius: BorderRadius.circular(19), color: Colors.white),
          child: ClipOval(
            child: Image.network(
                "https://img0.baidu.com/it/u=2456468987,3284231714&fm=26&fmt=auto&gp=0.jpg",
                fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}
