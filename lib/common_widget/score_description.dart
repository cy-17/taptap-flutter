import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/util/DrawUtil.dart';
import 'package:flutter/material.dart';

class ScoreDescription extends StatelessWidget {
  const ScoreDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    "9.0",
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
                  "3001个评价",
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
              Row(children: DrawUtil.getStar(5, 500, 4001)),
              Row(children: DrawUtil.getStar(4, 500, 4001)),
              Row(children: DrawUtil.getStar(3, 200, 3001)),
              Row(children: DrawUtil.getStar(2, 3000, 4000)),
              Row(children: DrawUtil.getStar(1, 89, 4000))
            ],
          ),
        )
      ],
    );
  }
}

class ScoreDescriptionBelow extends StatelessWidget {
  const ScoreDescriptionBelow({
    Key? key,
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
            "6.6 /最近7天 ",
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
