import 'package:TapTap/common_widget/loading_diglog.dart';
import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/entity/game_entity.dart';
import 'package:TapTap/pages/index/home/game_description/game_detail.dart';
import 'package:TapTap/service/download_service.dart';
import 'package:TapTap/service/rank_service.dart';
import 'package:TapTap/util/DigitUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class RankPage extends StatefulWidget {
  const RankPage({Key? key}) : super(key: key);

  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage>
    with AutomaticKeepAliveClientMixin {
  final List<Game> _gameList = [];
  late ScrollController _scrollController;
  int page = 1;
  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();

    _getRankData();
  }

  _getRankData() {
    RankService.getRank(page).then((value) => {
          this.setState(() {
            _gameList.addAll(value);
          })
        });
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
      onRefresh: () async {
        this.setState(() {
          page = 0;
          _getRankData();
        });
      },
      onLoad: () async {
        await Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              page++;
              _getRankData();
            });
          }
        });
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ListGameCard extends StatefulWidget {
  final Game game;
  final int index;
  const _ListGameCard({Key? key, required this.game, required this.index})
      : super(key: key);

  @override
  __ListGameCardState createState() => __ListGameCardState();
}

class __ListGameCardState extends State<_ListGameCard> {
  String _content = "下载";

  @override
  void initState() {
    super.initState();
    DownloadService.apkExist(widget.game.gameName!).then((value) {
      this.setState(() {
        if (value) _content = "打开";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              (widget.index + 1).toString(),
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            width: 2,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          GameDetail(gameId: widget.game.gameId)));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.game.gamePictureUrl!,
                width: 68,
                height: 68,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GameDetail(gameId: widget.game.gameId)));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    child: Text(
                      widget.game.gameName!,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
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
                        widget.game.score.toString(),
                        style: TextStyle(
                            color: AppColors.navActive,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Container(
                        width: 140,
                        child: Text(
                          widget.game.category
                              .toString()
                              .replaceAll("[", "")
                              .replaceAll("]", "")
                              .replaceAll(",", " "),
                          overflow: TextOverflow.clip,
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
            ),
          ),
          TextButton(
            onPressed: () {
              DownloadService.installApk("", widget.game.gameName!,
                  (current, total) {
                double progress = current / total;
                this.setState(() {
                  if (current == total) {
                    _content = "打开";
                  } else
                    _content = "${DigitUtil.formatNum(progress, 1)}%";
                });
              });
            },
            child: Text(
              _content,
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
          ),
        ],
      ),
    );
  }
}
