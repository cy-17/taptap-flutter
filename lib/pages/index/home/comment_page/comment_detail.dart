import 'package:TapTap/common_widget/comment_card.dart';
import 'package:TapTap/common_widget/loading_diglog.dart';
import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/entity/comment_entity.dart';
import 'package:TapTap/entity/game_entity.dart';
import 'package:TapTap/service/comment_service.dart';
import 'package:TapTap/service/game_service.dart';
import 'package:TapTap/util/DigitUtil.dart';
import 'package:TapTap/util/DrawUtil.dart';
import 'package:TapTap/util/GlobalData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CommentDetailPage extends StatefulWidget {
  final Comment comment;

  const CommentDetailPage({Key? key, required this.comment}) : super(key: key);

  @override
  _CommentDetailPageState createState() => _CommentDetailPageState();
}

class _CommentDetailPageState extends State<CommentDetailPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int page = 1;
  Game? _game;
  late EasyRefreshController _controller;
  late final TabController _tabController;
  final List<Tab> tabs = [
    Tab(
      text: '转发',
    ),
    Tab(
      text: '回复',
    )
  ];
  List<Widget> subCommentList = [];
  var _textController;
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _textController.addListener(() {});
    _tabController =
        TabController(length: tabs.length, vsync: this, initialIndex: 1);
    _controller = EasyRefreshController();
    GameService.getParticularGame(widget.comment.gameId!).then((value) {
      this.setState(() {
        _game = value;
      });
    });
    _getSubComment();
  }

  _getSubComment() {
    CommentService.getChildComment(widget.comment.commentId!, page)
        .then((value) {
      value.forEach((element) {
        this.setState(() {
          subCommentList.add(Padding(
            padding: const EdgeInsets.all(10),
            child: _SubCommentCard(comment: element),
          ));
        });
      });
    });
  }

  var initHeight = 500;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "评价详情",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_horiz),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height - 150,
              child: EasyRefresh(
                controller: _controller,
                onRefresh: () async {
                  this.setState(() {
                    subCommentList.clear();

                    page = 1;
                    _getSubComment();
                  });
                },
                onLoad: () async {
                  await Future.delayed(Duration(seconds: 2), () {
                    if (mounted) {
                      setState(() {
                        page++;
                        _getSubComment();
                      });
                    }
                  });
                },
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 8),
                      height: 80,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 7),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  _game == null
                                      ? "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fgss0.baidu.com%2F9vo3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2F3ac79f3df8dcd100bbef0d45708b4710b9122f66.jpg&refer=http%3A%2F%2Fgss0.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1626588836&t=9a482b92eb94047bbef59c03f2a58a90"
                                      : _game!.Icon!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 4.0, top: 8),
                                child: Text(
                                  _game == null ? "未知游戏" : _game!.gameName!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Row(
                                children: [
                                  Image.network(
                                    "https://img.tapimg.com/market/images/fcd13c990696ac0f9d0987b3a4adf973.png",
                                    fit: BoxFit.cover,
                                    width: 20,
                                  ),
                                  Text(
                                    "开发者入驻",
                                    style: TextStyle(
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.1),
                                        color: AppColors.navActive,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                    Divider(),
                    _CommentCard(comment: widget.comment),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: 7,
                        color: Colors.grey.withOpacity(0.1),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: Container(
                            color: Colors.white,
                            height: 30,
                            child: TabBar(
                              unselectedLabelColor:
                                  Colors.grey, //设置未选中时的字体颜色，tabs里面的字体样式优先级最高
                              unselectedLabelStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight
                                      .w700), //设置未选中时的字体样式，tabs里面的字体样式优先级最高
                              labelColor: AppColors
                                  .navActive, //设置选中时的字体颜色，tabs里面的字体样式优先级最高
                              labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight
                                      .w700), //设置选中时的字体样式，tabs里面的字体样式优先级最高
                              indicatorColor: AppColors.navActive,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorWeight: 4,
                              tabs: tabs,
                              controller: this._tabController,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(),
                          flex: 6,
                        ),
                        Flexible(
                          child: Text("赞 👍"),
                          flex: 2,
                        )
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          Text("排序方式"),
                          Spacer(),
                          Text("最早回复"),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: initHeight + 0.1 > subCommentList.length * 300
                          ? initHeight + 0.1
                          : subCommentList.length * 180,
                      child: TabBarView(
                        children: [
                          Container(),
                          Column(
                            children: [
                              Column(children: subCommentList),
                              Row(
                                children: [
                                  Flexible(child: Container(), flex: 1),
                                  Text("没有更多评论了"),
                                  Flexible(child: Container(), flex: 1)
                                ],
                              )
                            ],
                          ),
                        ],
                        controller: _tabController,
                      ),
                    ),
                  ],
                ),
              )),
          Divider(),
          Container(
            height: 50,
            child: Row(
              children: [
                Flexible(
                  flex: 5,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: "回复",
                          contentPadding: EdgeInsets.fromLTRB(
                              10, 17, 0, 12), //输入框内容部分设置padding，跳转跟icon的对其位置
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    child: TextButton(
                      child: Text(
                        "发表",
                        style: TextStyle(
                            color: AppColors.navActive,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(239, 249, 251, 1)),
                          //设置按钮的大小
                          minimumSize: MaterialStateProperty.all(Size(50, 20)),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 6)),
                          //外边框装饰 会覆盖 side 配置的样式
                          shape: MaterialStateProperty.all(
                              StadiumBorder(side: BorderSide(width: 1))),
                          //设置边框
                          side: MaterialStateProperty.all(
                              BorderSide(color: Colors.white, width: 1))),
                      onPressed: () {
                        //1.展示加载框
                        showDialog(
                            context: context,
                            builder: (context) {
                              return new LoadingDialog();
                            });
                        CommentService.writeSubComment(
                                widget.comment.gameId!,
                                widget.comment.commentId!,
                                widget.comment.commentUserId!,
                                _textController.text)
                            .then((value) {
                          if (value) {
                            Navigator.pop(context);
                            showAlertDialog(context);
                            Comment comment = Comment();
                            comment.commentTime = DateTime.now().toString();
                            comment.commentDetail = _textController.text;
                            comment.userCoverUrl =
                                GlobalData.userInfo!.userCoverUrl;
                            comment.userNickName =
                                GlobalData.userInfo!.userNickName;

                            this.setState(() {
                              subCommentList.add(Padding(
                                padding: const EdgeInsets.all(10),
                                child: _SubCommentCard(comment: comment),
                              ));
                              _textController.text = "";
                            });
                          }
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    //设置按钮
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    //设置对话框
    AlertDialog alert = AlertDialog(
      content: Text("评论成功"),
      actions: [
        okButton,
      ],
    );

    //显示对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _CommentCard extends StatelessWidget {
  final Comment comment;
  const _CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: ClipOval(
                    child: Image.network(
                      comment.userCoverUrl!.length == 0
                          ? "https://img0.baidu.com/it/u=1514002029,2035215441&fm=26&fmt=auto&gp=0.jpg"
                          : comment.userCoverUrl!,
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
                      comment.userNickName!,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(comment.commentTime!,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        )),
                  ],
                ),
                Spacer(),
                TextButton(
                  child: Text(
                    "关注",
                    style: TextStyle(
                        color: AppColors.navActive,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(239, 249, 251, 1)),
                      //设置按钮的大小
                      minimumSize: MaterialStateProperty.all(Size(50, 20)),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 24, vertical: 6)),
                      //外边框装饰 会覆盖 side 配置的样式
                      shape: MaterialStateProperty.all(
                          StadiumBorder(side: BorderSide(width: 1))),
                      //设置边框
                      side: MaterialStateProperty.all(
                          BorderSide(color: Colors.white, width: 1))),
                  onPressed: () {},
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
            child: Row(children: DrawUtil.getStarOnly(comment.commentScore!)),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CommentDetailPage(comment: comment)));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0, bottom: 1),
              child: Text(
                comment.commentDetail!,
                maxLines: 7,
                style: TextStyle(
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Spacer(),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [Text("华为Honer Magic2"), Spacer(), Text("游戏时长 92小时")],
            ),
          )
        ],
      ),
    );
  }
}

class _SubCommentCard extends StatelessWidget {
  final Comment comment;
  const _SubCommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: ClipOval(
                    child: Image.network(
                      comment.userCoverUrl!.length == 0
                          ? "https://img0.baidu.com/it/u=1514002029,2035215441&fm=26&fmt=auto&gp=0.jpg"
                          : comment.userCoverUrl!,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                      child: Text(
                        comment.userNickName!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        width: 285,
                        child: Text(
                          comment.commentDetail!,
                          textAlign: TextAlign.justify,
                          maxLines: 10,
                          style: TextStyle(
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.comment_bank,
                            color: Colors.grey,
                            size: 18,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Icon(
                            Icons.thumb_up,
                            color: Colors.grey,
                            size: 18,
                          ),
                          SizedBox(
                            width: 145,
                          ),
                          Container(
                            width: 80,
                            child: Text(
                              comment.commentTime!,
                              maxLines: 1,
                              style: TextStyle(overflow: TextOverflow.clip),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
