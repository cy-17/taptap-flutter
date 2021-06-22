import 'package:TapTap/common_widget/loading_diglog.dart';
import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/entity/game_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class RankPage extends StatefulWidget {
  const RankPage({Key? key}) : super(key: key);

  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  final List<Game> _gameList = [];
  late ScrollController _scrollController;
  @override
  void initState() {
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
    _gameList.add(Game(
        "三国志幻想大陆",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fmedia.9game.cn%2Fgamebase%2F2021%2F4%2F28%2F227016116_.jpg&refer=http%3A%2F%2Fmedia.9game.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1626449203&t=f10ee98c3ce0767cf3576358170604d7",
        "触手可及的美好三国！高颜值卡牌王者来袭，等你来玩！",
        7.1,
        "哥本哈根，一座极具童话气息的城市！ 本次地图降落在丹麦哥本哈根，跟随《地铁跑酷》一起来一场童话王国的邂逅！"));
    _gameList.add(Game(
        "三国志幻想大陆",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fmedia.9game.cn%2Fgamebase%2F2021%2F4%2F28%2F227016116_.jpg&refer=http%3A%2F%2Fmedia.9game.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1626449203&t=f10ee98c3ce0767cf3576358170604d7",
        "触手可及的美好三国！高颜值卡牌王者来袭，等你来玩！",
        7.1,
        "哥本哈根，一座极具童话气息的城市！ 本次地图降落在丹麦哥本哈根，跟随《地铁跑酷》一起来一场童话王国的邂逅！"));
    _gameList.add(Game(
        "三国志幻想大陆",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fmedia.9game.cn%2Fgamebase%2F2021%2F4%2F28%2F227016116_.jpg&refer=http%3A%2F%2Fmedia.9game.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1626449203&t=f10ee98c3ce0767cf3576358170604d7",
        "触手可及的美好三国！高颜值卡牌王者来袭，等你来玩！",
        7.1,
        "哥本哈根，一座极具童话气息的城市！ 本次地图降落在丹麦哥本哈根，跟随《地铁跑酷》一起来一场童话王国的邂逅！"));
  }

  _getRankData() {
    _gameList.add(Game(
        "三国志幻想大陆",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fmedia.9game.cn%2Fgamebase%2F2021%2F4%2F28%2F227016116_.jpg&refer=http%3A%2F%2Fmedia.9game.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1626449203&t=f10ee98c3ce0767cf3576358170604d7",
        "触手可及的美好三国！高颜值卡牌王者来袭，等你来玩！",
        7.1,
        "哥本哈根，一座极具童话气息的城市！ 本次地图降落在丹麦哥本哈根，跟随《地铁跑酷》一起来一场童话王国的邂逅！"));
    _gameList.add(Game(
        "三国志幻想大陆",
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fmedia.9game.cn%2Fgamebase%2F2021%2F4%2F28%2F227016116_.jpg&refer=http%3A%2F%2Fmedia.9game.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1626449203&t=f10ee98c3ce0767cf3576358170604d7",
        "触手可及的美好三国！高颜值卡牌王者来袭，等你来玩！",
        7.1,
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
          return _ListGameCard(
            game: _gameList[index],
            index: index,
          );
        }, childCount: _gameList.length)),
      ],
      onRefresh: () async {},
      onLoad: () async {
        await Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              _getRankData();
            });
          }
        });
      },
    );
  }
}

class _ListGameCard extends StatelessWidget {
  final Game game;
  final int index;
  const _ListGameCard({Key? key, required this.game, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              index.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            width: 2,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              game.gamePictureUrl,
              width: 68,
              height: 68,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                game.gameName,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: AppColors.navActive,
                    size: 15,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    game.score.toString(),
                    style: TextStyle(
                        color: AppColors.navActive,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Container(
                    width: 150,
                    child: Text(
                      game.category.toString(),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              )
            ],
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "下载",
              style: TextStyle(color: AppColors.navActive, fontSize: 15),
            ),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color.fromRGBO(239, 249, 251, 1)),
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
          )
        ],
      ),
    );
  }
}
