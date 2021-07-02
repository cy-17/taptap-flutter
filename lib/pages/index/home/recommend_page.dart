import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/entity/game_entity.dart';
import 'package:TapTap/pages/index/home/game_description/game_detail.dart';
import 'package:TapTap/service/game_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({Key? key}) : super(key: key);

  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  final List<Game> _gameList = [];
  int page = 1;
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _getRecommendData();
  }

  _getRecommendData() {
    GameService.getRecommend(page).then((value) {
      this.setState(() {
        _gameList.addAll(value);
      });
    });
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
      onRefresh: () async {
        this.setState(() {
          page = 0;
          _getRecommendData();
        });
      },
      onLoad: () async {
        await Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              page++;
              _getRecommendData();
            });
          }
        });
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class GameCard extends StatelessWidget {
  final Game game;
  const GameCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GameDetail(gameId: game.gameId)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 250,
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Image.network(
              game.gamePictureUrl!,
              width: double.infinity,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          _GameDescription(game: game)
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
      ),
    );
  }
}

class _GameDescription extends StatelessWidget {
  const _GameDescription({
    Key? key,
    required this.game,
  }) : super(key: key);

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 160,
                child: Text(
                  game.gameName!,
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 260),
                child: Text(
                  game.description!,
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
            padding: EdgeInsets.only(bottom: 20, right: 10, left: 10),
            child: Column(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  child: Image.asset(
                    "assets/images/home/recommend/taptap.jpg",
                  ),
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
    );
  }
}
