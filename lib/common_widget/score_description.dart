import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/util/DrawUtil.dart';
import 'package:flutter/material.dart';

class ScoreDescription extends StatelessWidget {
  final int score;
  final Map<String, dynamic> countScore;

  const ScoreDescription({
    Key? key,
    required this.score,
    required this.countScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int total = countScore["5"] +
        countScore["4"] +
        countScore["3"] +
        countScore["2"] +
        countScore["1"];
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 30,
                    color: AppColors.navActive,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "$score",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: AppColors.navActive),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Text(
                  "$total个评价",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: AppColors.navActive),
                ),
              )
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(children: DrawUtil.getStar(5, countScore["5"], total)),
              Row(children: DrawUtil.getStar(4, countScore["4"], total)),
              Row(children: DrawUtil.getStar(3, countScore["3"], total)),
              Row(children: DrawUtil.getStar(2, countScore["2"], total)),
              Row(children: DrawUtil.getStar(1, countScore["1"], total))
            ],
          ),
        )
      ],
    );
  }
}

class ScoreDescriptionBelow extends StatelessWidget {
  final int score;
  const ScoreDescriptionBelow({
    Key? key,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            "最新版本",
            style: TextStyle(fontSize: 13),
          ),
          SizedBox(
            width: 4,
          ),
          Icon(
            Icons.star,
            size: 15,
            color: Colors.grey,
          ),
          Text(
            "$score /最近7天 ",
            style: TextStyle(fontSize: 13),
          ),
          SizedBox(
            width: 4,
          ),
          Icon(
            Icons.star,
            size: 15,
            color: Colors.grey,
          ),
          Text(
            "暂无",
            style: TextStyle(fontSize: 13),
          ),
          Spacer(),
          Icon(
            Icons.open_in_new,
            size: 15,
            color: Colors.grey,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            "评价",
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
