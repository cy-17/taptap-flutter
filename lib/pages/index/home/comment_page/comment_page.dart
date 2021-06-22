import 'package:TapTap/common_widget/comment_card.dart';
import 'package:TapTap/common_widget/score_description.dart';
import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/pages/index/home/comment_page/write_comment_page.dart';
import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => WriteCommentPage()));
        },
        backgroundColor: AppColors.navActive,
        child: Icon(Icons.border_color),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
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
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ScoreDescription(),
          ),
          SizedBox(
            height: 20,
          ),
          ScoreDescriptionBelow(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
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
          ),
          SizedBox(
            height: 20,
          ),
          CommentCard(),
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CommentCard(),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CommentCard(),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CommentCard(),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CommentCard(),
          )
        ],
      ),
    );
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
}
