import 'dart:ffi';

import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/entity/game_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({Key? key}) : super(key: key);

  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  final List<Game> _gameList = [];
  late ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = new ScrollController();
    _gameList.add(Game(
        "地铁跑酷",
        "http://pao.uu.cc/manage/upload/image/pao.uu.cc/2021-06-11/20210611_183230_110015.png",
        "休闲",
        9.3,
        "哥本哈根，一座极具童话气息的城市！ 本次地图降落在丹麦哥本哈根，跟随《地铁跑酷》一起来一场童话王国的邂逅！"));
    _gameList.add(Game(
        "三国志幻想大陆",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fmedia.9game.cn%2Fgamebase%2F2021%2F4%2F28%2F227016116_.jpg&refer=http%3A%2F%2Fmedia.9game.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1626449203&t=f10ee98c3ce0767cf3576358170604d7",
        "触手可及的美好三国！高颜值卡牌王者来袭，等你来玩！",
        7.1,
        "哥本哈根，一座极具童话气息的城市！ 本次地图降落在丹麦哥本哈根，跟随《地铁跑酷》一起来一场童话王国的邂逅！"));
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      scrollController: _scrollController,
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return GameCard(
            game: _gameList[index],
          );
        }, childCount: _gameList.length)),
      ],
      onRefresh: () async {},
      onLoad: () async {
        await Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              print("fsfs");
            });
          }
        });
      },
    );
  }
}

class GameCard extends StatelessWidget {
  final Game game;
  const GameCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 280,
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Image.network(
            game.gamePictureUrl,
            width: double.infinity,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.gameName,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 300),
                    child: Text(
                      game.category,
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 13, left: 10),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/home/recommend/taptap.jpg",
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      "${game.score}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.navActive),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ]),
      decoration: BoxDecoration(
          // 底色
          boxShadow: [
            BoxShadow(
              blurRadius: 15, //阴影范围
              spreadRadius: 8, //阴影浓度
              color: Color(0xFFF7F7F7),
            ),
          ], borderRadius: BorderRadius.circular(19), color: Colors.white),
    );
  }
}
