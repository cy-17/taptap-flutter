import 'package:TapTap/util/CONSTUtil.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> _bottomNavBarItemList = [];
  int _currntIndex = 0;
  @override
  void initState() {
    super.initState();
    CONSTUtil.bottomNames.forEach((key, value) {
      _bottomNavBarItemList.add(_bottomNavBarItem(key, value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CONSTUtil.pageList[_currntIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onTabClick,
          currentIndex: _currntIndex,
          type: BottomNavigationBarType.fixed,
          items: _bottomNavBarItemList),
    );
  }

  BottomNavigationBarItem _bottomNavBarItem(String key, String value) {
    return BottomNavigationBarItem(
      activeIcon: Opacity(
        opacity: 0.5,
        child: Image.asset("assets/images/index/${key}_active.png",
            width: 32, height: 32, fit: BoxFit.cover),
      ),
      label: "$value",
      icon: Image.asset("assets/images/index/$key.png",
          width: 32, height: 32, fit: BoxFit.cover),
    );
  }

  void _onTabClick(int value) {
    this.setState(() {
      this._currntIndex = value;
    });
  }
}
