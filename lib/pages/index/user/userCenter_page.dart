import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/util/DrawUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserCenterPage extends StatefulWidget {
  const UserCenterPage({Key? key}) : super(key: key);

  @override
  _UserCenterPageState createState() => _UserCenterPageState();
}

class _UserCenterPageState extends State<UserCenterPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final List<Tab> tabs = [
    Tab(
      text: '主页',
    ),
    Tab(
      text: '发布',
    ),
    Tab(
      text: '关于',
    ),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                height: 270,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/home/drawer/drawer_backgroud.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        bottom: 10,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipOval(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 5, color: Colors.white)),
                                        child: Image.network(
                                          "https://img0.baidu.com/it/u=2456468987,3284231714&fm=26&fmt=auto&gp=0.jpg",
                                          fit: BoxFit.cover,
                                          width: 60,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.thumb_up,
                                              color: Colors.white,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                "0",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Icon(
                                              Icons.face,
                                              color: Colors.white,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "0",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TextButton(
                                            style: ButtonStyle(
                                                //设置按钮的大小
                                                minimumSize:
                                                    MaterialStateProperty.all(
                                                        Size(50, 20)),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12,
                                                            vertical: 3)),
                                                //外边框装饰 会覆盖 side 配置的样式
                                                shape:
                                                    MaterialStateProperty.all(
                                                        StadiumBorder()),
                                                //设置边框
                                                side: MaterialStateProperty.all(
                                                    BorderSide(
                                                        color: Colors.white,
                                                        width: 1))),
                                            onPressed: () {},
                                            child: Text(
                                              "修改资料",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w800),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("帅不帅",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        width: 25,
                                        height: 15,
                                        child: Center(
                                          child: Text("礼仪",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 9,
                                              )),
                                        ),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(3))),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("ID: 367842561",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 12,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Text("0",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("粉丝",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 15,
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("1",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("关注",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 15,
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("0",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("收藏",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 15,
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Hello Gamer!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    )),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: TabBar(
                  unselectedLabelColor:
                      Colors.grey, //设置未选中时的字体颜色，tabs里面的字体样式优先级最高
                  unselectedLabelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight:
                          FontWeight.w700), //设置未选中时的字体样式，tabs里面的字体样式优先级最高
                  labelColor: AppColors.navActive, //设置选中时的字体颜色，tabs里面的字体样式优先级最高
                  labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.w700), //设置选中时的字体样式，tabs里面的字体样式优先级最高
                  indicatorColor: AppColors.navActive,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 4,
                  tabs: tabs,
                  controller: this._tabController,
                ),
              ),
              SizedBox(
                height: 13,
              ),
              Container(
                height: height - 80,
                child: TabBarView(
                  children: [_HomePage(), _FABU(), _About()],
                  controller: _tabController,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.white,
                        size: 37,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _About extends StatelessWidget {
  const _About({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.red,
    );
  }
}

class _FABU extends StatelessWidget {
  const _FABU({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.red,
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [_CommentCard()],
    );
  }
}

class _CommentCard extends StatefulWidget {
  const _CommentCard({Key? key}) : super(key: key);

  @override
  __CommentCardState createState() => __CommentCardState();
}

class __CommentCardState extends State<_CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 5),
                  child: ClipOval(
                    child: Image.network(
                      "https://img1.baidu.com/it/u=2697754602,2032230362&fm=26&fmt=auto&gp=0.jpg",
                      fit: BoxFit.cover,
                      width: 50,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "菲菲-颜子-小丽",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w800),
                    ),
                    Text("2天前",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        )),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://img2.baidu.com/it/u=3179073811,4006045172&fm=26&fmt=auto&gp=0.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "无极仙途",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Text(
                      "1.9+评价  帖子1.8万+",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 11),
            child: Row(
              children: [
                Text(
                  "评分",
                  style: TextStyle(
                      color: AppColors.navActive,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 6,
                ),
                Row(children: DrawUtil.getStarOnly(5)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 1),
            child: Text(
              "   感谢育碧的邀请，让我们得以提前试玩了《彩虹六号：异种》。作为脱胎于前作“围攻”内特殊模式的系列新作，本次的”异种“在保留以往优秀射击手感和诸多特色元素的同时，将主题从反恐对抗变成了合作共斗。尽管区区一个下午的试玩并没能让我窥得本作全貌，却依然获得了一些值得和大家分享的信息。以下，就是我本次的试玩体验。Ps：本次试玩为Demo版本，并不代表游戏上市后最终素质",
              maxLines: 7,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.share),
            ],
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
