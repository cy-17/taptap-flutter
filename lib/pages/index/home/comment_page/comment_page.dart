import 'dart:async';

import 'package:TapTap/common_widget/comment_card.dart';
import 'package:TapTap/common_widget/loading_diglog.dart';
import 'package:TapTap/common_widget/score_description.dart';
import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/entity/game_entity.dart';
import 'package:TapTap/pages/index/home/comment_page/write_comment_page.dart';
import 'package:TapTap/service/comment_service.dart';
import 'package:TapTap/service/game_service.dart';
import 'package:TapTap/util/DigitUtil.dart';
import 'package:TapTap/util/DrawUtil.dart';
import 'package:TapTap/util/GlobalData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CommentPage extends StatefulWidget {
  String scroe;
  Map<String, dynamic> countScore;
  final int gameId;
  CommentPage(
      {Key? key,
      required this.scroe,
      required this.countScore,
      required this.gameId})
      : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage>
    with AutomaticKeepAliveClientMixin {
  List<Widget> gameFirstComment = [];
  List<Widget> userCommentList = [];
  late EasyRefreshController _controller;
  int page = 1;
  @override
  void initState() {
    super.initState();
    _getUserComment();
    _controller = EasyRefreshController();
    _getComment();
  }

  _getUserComment() {
    print("object");
    if (GlobalData.userInfo != null) {
      CommentService.getCommentByUserIdAndGameId(
              GlobalData.userInfo!.userId!, widget.gameId, page)
          .then((value) => this.setState(() {
                value.forEach((element) {
                  userCommentList.add(Padding(
                    padding: const EdgeInsets.all(10),
                    child: CommentCard(
                      comment: element,
                      callback: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return new LoadingDialog();
                            });

                        CommentService.deleteComment(
                            GlobalData.userInfo!.userId!,
                            element.gameId!,
                            element.commentId!);
                        Timer.periodic(Duration(seconds: 1), (timer) {
                          timer.cancel();
                          Navigator.pop(context);
                          DrawUtil.showAlertDialog(context, "删除成功");
                        });
                      },
                    ),
                  ));
                });
              }));
    }
  }

  _getComment() async {
    CommentService.getOneComment(widget.gameId, page).then((value) {
      value.forEach((element) {
        if (GlobalData.userInfo != null) {
          if (element.commentUserId != GlobalData.userInfo!.userId)
            this.setState(() {
              gameFirstComment.add(Padding(
                padding: const EdgeInsets.all(10),
                child: CommentCard(comment: element),
              ));
            });
        } else
          this.setState(() {
            gameFirstComment.add(Padding(
              padding: const EdgeInsets.all(10),
              child: CommentCard(comment: element),
            ));
          });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: GlobalData.userInfo == null
            ? Container()
            : FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              WriteCommentPage(gameId: widget.gameId)));
                },
                backgroundColor: AppColors.navActive,
                child: Icon(Icons.border_color),
              ),
        body: Stack(
          children: [
            EasyRefresh(
              controller: _controller,
              child: ListView(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ScoreDescription(
                      score: widget.scroe,
                      countScore: widget.countScore,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ScoreDescriptionBelow(
                    score: widget.scroe,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GlobalData.userInfo == null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "我的评价",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 23,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                              Column(
                                children: userCommentList,
                              )
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  // CommentCard(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          "游戏评价",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.w900),
                        ),
                        Spacer(),
                        Text(
                          "默认",
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 20,
                        )
                      ],
                    ),
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
                  Column(
                    children: gameFirstComment,
                  )
                ],
              ),
              onRefresh: () async {
                GameService.getParticularGame(widget.gameId).then((value) {
                  this.setState(() {
                    widget.countScore = value.GameCommentScore!;
                    int total = value.GameCommentScore!["5"] +
                        value.GameCommentScore!["4"] +
                        value.GameCommentScore!["3"] +
                        value.GameCommentScore!["2"] +
                        value.GameCommentScore!["1"];
                    widget.scroe = DigitUtil.formatNum(
                        ((5 * value.GameCommentScore!["5"] +
                                    4 * value.GameCommentScore!["4"] +
                                    3 * value.GameCommentScore!["3"] +
                                    2 * value.GameCommentScore!["2"] +
                                    value.GameCommentScore!["1"]) *
                                2) /
                            total,
                        1);
                  });
                });
                this.setState(() {
                  page = 1;
                  gameFirstComment.clear();
                  userCommentList.clear();
                  _getUserComment();
                  _getComment();
                });
              },
              onLoad: () async {
                await Future.delayed(Duration(seconds: 2), () {
                  if (mounted) {
                    setState(() {
                      page++;
                      _getComment();
                    });
                  }
                });
              },
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.grey,
                        size: 35,
                      ),
                    ),
                    Text(
                      "评分 & 评价",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  List<String> tags = ["全部", "同设备", "有游戏时长", "好评", "好评", "好评", "好评"];
  List<bool> colorCheck = [true, false, false, false, false, false, false];
  Widget _colorLvItem(index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          for (int i = 0; i < colorCheck.length; i++) {
            colorCheck[i] = (i == index);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: new BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.withOpacity(0.3)),
          color: colorCheck[index] ? AppColors.navActive : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Text(
          tags[index],
          style: TextStyle(
              color: colorCheck[index] ? Colors.white : AppColors.navActive,
              fontSize: 16.0,
              decoration: TextDecoration.none),
        ),
      ),
    );
  }

  List<Widget> _widgets(State state) {
    return tags.asMap().keys.map((index) => _colorLvItem(index)).toList();
  }

  @override
  bool get wantKeepAlive => true;
}
