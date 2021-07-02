import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/entity/comment_entity.dart';
import 'package:TapTap/entity/user_info.dart';
import 'package:TapTap/pages/index/home/game_description/game_detail.dart';
import 'package:TapTap/pages/index/user/change_info.dart';
import 'package:TapTap/service/comment_service.dart';
import 'package:TapTap/util/DrawUtil.dart';
import 'package:TapTap/util/GlobalData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserCenterPage extends StatefulWidget {
  const UserCenterPage({Key? key}) : super(key: key);

  @override
  _UserCenterPageState createState() => _UserCenterPageState();
}

class _UserCenterPageState extends State<UserCenterPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
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
                                          GlobalData.userInfo!.userCoverUrl!,
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserInfoPage()));
                                            },
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
                                Text(
                                    GlobalData.userInfo == null
                                        ? "帅不帅"
                                        : GlobalData.userInfo!.userNickName!,
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
                                    Text(
                                        "ID: ${GlobalData.userInfo!.userId ?? 1321312}",
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
                height: height - 200,
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
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

class _HomePage extends StatefulWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  __HomePageState createState() => __HomePageState();
}

class __HomePageState extends State<_HomePage> {
  late List<Widget> commentList = [];
  int page = 1;
  @override
  void initState() {
    super.initState();
    CommentService.getCommentByUserId(GlobalData.userInfo!.userId!, page)
        .then((value) => this.setState(() {
              value.forEach((element) {
                commentList.add(_CommentCard(comment: element));
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(children: commentList.length > 0 ? commentList : []),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text("暂无更多")),
        )
      ],
    );
  }
}

class _CommentCard extends StatefulWidget {
  final Comment comment;
  const _CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  __CommentCardState createState() => __CommentCardState();
}

class __CommentCardState extends State<_CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                          GlobalData.userInfo!.userCoverUrl!,
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
                          GlobalData.userInfo!.userNickName!,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("${widget.comment.commentTime ?? '2天前'}",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GameDetail(gameId: widget.comment.gameId)));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 14),
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
                            "${widget.comment.commentGameCoverUrl}",
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
                            "${widget.comment.commentGameName}",
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          SizedBox(
                            height: 5,
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
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 11),
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
                    Row(
                        children:
                            DrawUtil.getStarOnly(widget.comment.commentScore!)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 1, top: 5),
                child: Text(
                  widget.comment.commentDetail ?? "unknown",
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    child: Center(
                      child: Image.asset("assets/images/home/share.png"),
                    ),
                  ),
                  Flexible(flex: 1, child: Container()),
                  Icon(
                    Icons.comment_bank,
                    color: Colors.grey.withOpacity(0.6),
                  ),
                  Flexible(flex: 1, child: Container()),
                  Icon(Icons.thumb_up, color: Colors.grey.withOpacity(0.6)),
                  Spacer(),
                  Flexible(flex: 2, child: Container()),
                  Icon(Icons.more_vert, color: Colors.grey.withOpacity(0.6))
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Divider()
            ],
          ),
        ),
      ],
    );
  }
}
