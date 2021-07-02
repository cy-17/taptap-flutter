import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/pages/index/Login/login_page.dart';
import 'package:TapTap/pages/index/user/change_info.dart';
import 'package:TapTap/pages/index/user/userCenter_page.dart';
import 'package:TapTap/util/CONSTUtil.dart';
import 'package:TapTap/util/GlobalData.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: CONSTUtil.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      onDrawerChanged: (open) {
        this.setState(() {});
      },
      drawer: _HomeDrawer(),
      appBar: AppBar(
        leadingWidth: 0,
        leading: Container(),
        actions: [
          _PersonImage(scaffoldKey: _scaffoldKey),
        ],
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

class _HomeDrawer extends StatelessWidget {
  const _HomeDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: _DrawerListView(),
    );
  }
}

class _DrawerListView extends StatefulWidget {
  _DrawerListView({Key? key}) : super(key: key);

  @override
  __DrawerListViewState createState() => __DrawerListViewState();
}

class __DrawerListViewState extends State<_DrawerListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      //抽屉里面一个list部件
      padding: EdgeInsets.all(0), //顶部padding为0
      children: <Widget>[
        //所有子部件
        UserAccountsDrawerHeader(
          otherAccountsPicturesSize: Size.square(25),
          otherAccountsPictures: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        settings: RouteSettings(name: "homePage"),
                        builder: (context) => UserInfoPage()));
              },
              child: Image.asset(
                "assets/images/home/drawer/drawer_saoyisao.png",
                fit: BoxFit.cover,
              ),
            )
          ],
          //用户信息栏
          accountName: Text(
            GlobalData.userInfo == null
                ? "点击头像登陆"
                : GlobalData.userInfo!.userNickName!,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
          ),
          accountEmail: Text(""),
          currentAccountPicture: InkWell(
            onTap: () {
              if (GlobalData.userInfo == null)
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              else
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        settings: RouteSettings(name: "homePage"),
                        builder: (context) => UserCenterPage()));
            },
            child: CircleAvatar(
              child: GlobalData.userInfo != null
                  ? ClipOval(
                      child: Image.network(
                        GlobalData.userInfo!.userCoverUrl!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipOval(
                      child: Image.asset(
                          "assets/images/home/drawer/loginImage.png",
                          fit: BoxFit.cover),
                    ),
              //头像

              //图片不变性裁剪居中显示
            ),
          ),

          onDetailsPressed: () {}, //下拉箭头
          decoration: BoxDecoration(
            //背景图片
            image: DecorationImage(
                fit: BoxFit.cover,
                image:
                    AssetImage("assets/images/home/drawer/drawer_backgroud.png")
                //图片不变性裁剪居中显示
                ),
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Image.asset(
                "assets/images/home/drawer/drawer_dynamic.png",
                width: 25,
                height: 25,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '动态',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Image.asset(
                "assets/images/home/drawer/drawer_attention.png",
                width: 25,
                height: 25,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '关注',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Image.asset(
                "assets/images/home/drawer/drawer_friend.png",
                width: 25,
                height: 25,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '好友',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),

        ListTile(
          title: Row(
            children: [
              Image.asset(
                "assets/images/home/drawer/drawe_favorite.png",
                width: 25,
                height: 25,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '收藏',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Image.asset(
                "assets/images/home/drawer/drawer_ order.png",
                width: 25,
                height: 25,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '订单',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Image.asset(
                "assets/images/home/drawer/drawer_history.png",
                width: 25,
                height: 25,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '浏览历史',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        Divider(),
        ListTile(
          title: Row(
            children: [
              Image.asset(
                "assets/images/home/drawer/drawer_zhoubian.png",
                width: 25,
                height: 25,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  'TapTap周边',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Image.asset(
                "assets/images/home/drawer/drawer_duihuan.png",
                width: 25,
                height: 25,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '兑换中心',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Image.asset(
                "assets/images/home/drawer/drawer_advice.png",
                width: 25,
                height: 25,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '建议和反馈',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Image.asset(
                "assets/images/home/drawer/drawer_setting.png",
                width: 25,
                height: 25,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '设置',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Image.asset(
                "assets/images/home/drawer/drawer_night.png",
                width: 25,
                height: 25,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '夜间模式',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Image.asset(
                "assets/images/home/drawer/drawer_version.png",
                width: 25,
                height: 25,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '当前版本',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        GlobalData.userInfo != null
            ? InkWell(
                onTap: () {
                  this.setState(() {
                    GlobalData.userInfo = null;
                  });
                },
                child: ListTile(
                  title: Row(
                    children: [
                      Image.asset(
                        "assets/images/home/drawer/drawer_version.png",
                        width: 25,
                        height: 25,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          '退出登录',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}

class _PersonImage extends StatelessWidget {
  const _PersonImage({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      alignment: Alignment.center,
      width: 35,
      height: 35,
      child: InkWell(
        onTap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        child: ClipOval(
          child: Image.network(
              GlobalData.userInfo == null
                  ? "https://cyw-file.oss-cn-beijing.aliyuncs.com/loginImage.png"
                  : GlobalData.userInfo!.userCoverUrl!,
              fit: BoxFit.cover),
        ),
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
                fontSize: 16,
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
          width: 35,
          height: 35,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(left: 5),
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
      ],
    );
  }
}
