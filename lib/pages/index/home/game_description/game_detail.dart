import 'package:TapTap/common_widget/comment_card.dart';
import 'package:TapTap/common_widget/score_description.dart';
import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/entity/comment_entity.dart';
import 'package:TapTap/entity/game_entity.dart';
import 'package:TapTap/pages/index/home/comment_page/comment_page.dart';
import 'package:TapTap/service/comment_service.dart';
import 'package:TapTap/service/download_service.dart';
import 'package:TapTap/service/game_service.dart';
import 'package:TapTap/util/DigitUtil.dart';
import 'package:flutter/material.dart';

class GameDetail extends StatefulWidget {
  final gameId;
  const GameDetail({Key? key, this.gameId}) : super(key: key);

  @override
  _GameDetailState createState() => _GameDetailState();
}

class _GameDetailState extends State<GameDetail> {
  Game? _game;
  List<Widget>? imageList;
  List<String> tags = [];
  List<Widget> gameFirstComment = [];

  int total = 0;

  Widget _colorLvItem(index) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: new BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.withOpacity(0.3)),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Text(
          tags[index],
          style: TextStyle(
              color: AppColors.navActive,
              fontSize: 16.0,
              decoration: TextDecoration.none),
        ),
      ),
    );
  }

  String status = "安装";
  List<Widget> _widgets(State state) {
    return tags.asMap().keys.map((index) => _colorLvItem(index)).toList();
  }

  @override
  void initState() {
    super.initState();
    _getGameDetail();
    _getComment();
  }

  _getGameDetail() async {
    GameService.getParticularGame(widget.gameId).then((value) {
      this.setState(() {
        DownloadService.apkExist(value.gameName!).then((value) => {
              if (value)
                this.setState(() {
                  status = "打开";
                })
            });
        _game = value;
        total = _game!.GameCommentScore!["5"] +
            _game!.GameCommentScore!["4"] +
            _game!.GameCommentScore!["3"] +
            _game!.GameCommentScore!["2"] +
            _game!.GameCommentScore!["1"];
        value.categorys!.forEach((element) {
          tags.add(element.toString());
        });
        imageList = [];
        value.detailImages!.forEach((element) {
          imageList!.add(
            Image.network(
              element,
              fit: BoxFit.cover,
            ),
          );
        });
      });
    });
  }

  _getComment() async {
    CommentService.getOneComment(widget.gameId, 1).then((value) {
      value.forEach((element) {
        this.setState(() {
          gameFirstComment.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: CommentCard(comment: element),
          ));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 17 / 12,
                    child: Image.network(
                      _game == null
                          ? "https://img0.baidu.com/it/u=1629891177,4078810120&fm=11&fmt=auto&gp=0.jpg"
                          : _game!.gamePictureUrl!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        width: 700,
                        height: 80,
                        color: Colors.grey.withOpacity(0.7),
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
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    _game == null ? "未知游戏" : _game!.gameName!,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "游戏性测试",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
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
                            )
                          ],
                        ),
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "开发",
                              style: TextStyle(color: AppColors.un3active),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              _game == null ? "未知工作室" : _game!.author!,
                              style: TextStyle(color: AppColors.active),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "关注",
                              style: TextStyle(color: AppColors.un3active),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "7.5万",
                              style: TextStyle(color: AppColors.active),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              "帖子",
                              style: TextStyle(color: AppColors.un3active),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "51",
                              style: TextStyle(color: AppColors.active),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(children: [
                      Container(
                        width: 45,
                        height: 45,
                        child: Image.asset(
                          "assets/images/home/recommend/taptap.jpg",
                        ),
                      ),
                      Text(
                        _game == null ? "0.0" : "${_game!.score!}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: AppColors.navActive),
                      )
                    ])
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: RawMaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    DownloadService.installApk("", _game!.gameName!,
                        (current, total) {
                      double progress = current / total;
                      this.setState(() {
                        if (current == total) {
                          status = "打开";
                        } else
                          status = "正在下载：${DigitUtil.formatNum(progress, 1)}%";
                      });
                    });
                  },
                  elevation: 2.0,
                  fillColor: AppColors.navActive,
                  child: Text(
                    status,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 138),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.favorite_border_rounded,
                        color: AppColors.navActive,
                      ),
                      Text(
                        "关注",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 20,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentPage(
                                    gameId: _game!.gameId!,
                                    scroe: _game!.score!,
                                    countScore: _game!.GameCommentScore!,
                                  )));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.star_border_rounded,
                          color: AppColors.navActive,
                        ),
                        Text(
                          "评价$total",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 20,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.chat_bubble_outline_outlined,
                        color: AppColors.navActive,
                      ),
                      Text(
                        "论坛",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: imageList != null
                        ? imageList!
                        : [
                            Image.network(
                              "https://ns-strategy.cdn.bcebos.com/ns-strategy/upload/fc_big_pic/part-00797-1698.jpg",
                              fit: BoxFit.cover,
                            ),
                          ],
                  )),
              SizedBox(
                height: 20,
              ),
              DetailWidget(
                content: "简介",
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 30,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GameLabel(
                      label: "108热门榜",
                      visible: true,
                    ),
                    GameLabel(
                      label: "模拟",
                      visible: false,
                    ),
                    GameLabel(
                      label: "文字",
                      visible: false,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(_game != null
                    ? _game!.description!
                    : "玩家将扮演中国古代家族的先祖之灵，从秦朝开始守护自己的家族，目标是让（看看）自己的家族努力挣扎在历史长河之中，生生不息，成为传承千年的权..."),
              ),
              DetailWidget(content: "开发者的话"),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                    "[注意]\n将扮演中国古代家族的先祖之灵，从秦朝开始守护自己的家族，目标是让（看看）自己的家族努力挣扎在历史长河之中，生生不息，成为传承千年的权..."),
              ),
              SizedBox(
                height: 20,
              ),
              DetailWidget(content: "评分&评价"),
              SizedBox(
                height: 20,
              ),
              ScoreDescription(
                score: _game == null ? 0 : _game!.score!,
                countScore: _game == null ? Map() : _game!.GameCommentScore!,
              ),
              SizedBox(
                height: 15,
              ),
              ScoreDescriptionBelow(
                score: _game != null ? _game!.score! : 0,
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _widgets(this),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 250,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: gameFirstComment),
                  )),
              Container(
                padding: EdgeInsets.all(20),
                child: RawMaterialButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1, color: Colors.grey.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommentPage(
                                  gameId: _game!.gameId!,
                                  scroe: _game!.score!,
                                  countScore: _game!.GameCommentScore!,
                                )));
                  },
                  elevation: 2.0,
                  child: Text(
                    "查看评分&评价",
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.navActive,
                        fontWeight: FontWeight.w600),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 90),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(children: [
                    Text(
                      "详细信息",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.w900),
                    ),
                  ])),
              SizedBox(
                height: 5,
              ),
              DetailMessage(
                left: "开发",
                right: _game != null ? _game!.author! : "未知作者",
                positive: true,
              ),
              DetailMessage(
                left: "alfagame自交流2群",
                right: "2949328492",
                icon: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Icon(
                    Icons.copy,
                    color: AppColors.navActive,
                    size: 15,
                  ),
                ),
                positive: true,
              ),
              DetailMessage(
                left: "语言",
                right: "简体中文",
                icon: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 15,
                  ),
                ),
                positive: false,
              ),
              DetailMessage(
                left: "当前版本",
                right: "GodlessMyFamily",
                positive: false,
              ),
              DetailMessage(
                left: "游戏大小",
                right: "60MB",
                positive: false,
              ),
              DetailMessage(
                left: "更新时间",
                right: _game != null ? _game!.releaseDate! : "2019-06-30",
                positive: false,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    width: 35,
                    height: 35,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: ClipOval(
                        child: Container(
                          color: Colors.grey.withOpacity(0.3),
                          child: Center(
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10, top: 10),
                    width: 35,
                    height: 35,
                    child: ClipOval(
                      child: Container(
                        color: Colors.grey.withOpacity(0.3),
                        child: Center(
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              alignment: Alignment.topLeft,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailMessage extends StatelessWidget {
  final String left;
  final String right;
  final bool positive;
  final Widget? icon;
  const DetailMessage({
    Key? key,
    required this.left,
    required this.right,
    required this.positive,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(left),
              Spacer(),
              Text(
                right,
                style: TextStyle(
                    color: positive ? AppColors.navActive : Colors.grey),
              ),
              icon ?? Container(),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}

class GameLabel extends StatelessWidget {
  final String label;
  final bool visible;
  const GameLabel({
    Key? key,
    required this.label,
    required this.visible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                color: visible
                    ? Color.fromRGBO(253, 240, 242, 1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20))),
            child: Row(
              children: [
                visible
                    ? Icon(
                        Icons.query_builder,
                        size: 19,
                        color: Color.fromRGBO(239, 131, 98, 1),
                      )
                    : Container(),
                Text(
                  label,
                  style: TextStyle(
                      color: visible
                          ? Color.fromRGBO(239, 131, 98, 1)
                          : Colors.grey),
                ),
                visible
                    ? Container()
                    : Icon(
                        Icons.keyboard_arrow_right,
                        size: 19,
                        color: Colors.grey,
                      )
              ],
            ))
      ],
    );
  }
}

class DetailWidget extends StatelessWidget {
  final String content;

  const DetailWidget({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GameDetail()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Text(
              content,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.w900),
            ),
            Spacer(),
            Text(
              "查看全部",
              style: TextStyle(
                  color: AppColors.navActive,
                  fontSize: 15,
                  fontWeight: FontWeight.w800),
            )
          ],
        ),
      ),
    );
  }
}
