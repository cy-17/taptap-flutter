import 'package:TapTap/util/DrawUtil.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 5),
                  child: ClipOval(
                    child: Image.network(
                      "https://img1.baidu.com/it/u=2697754602,2032230362&fm=26&fmt=auto&gp=0.jpg",
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
                      "菲菲-颜子-小丽",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w800),
                    ),
                    Text("2天前",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        )),
                  ],
                ),
                Spacer(),
                Spacer(),
                Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(children: DrawUtil.getStarOnly(5)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 1),
            child: Text(
              "感谢育碧的邀请，让我们得以提前试玩了《彩虹六号：异种》。作为脱胎于前作“围攻”内特殊模式的系列新作，本次的”异种“在保留以往优秀射击手感和诸多特色元素的同时，将主题从反恐对抗变成了合作共斗。尽管区区一个下午的试玩并没能让我窥得本作全貌，却依然获得了一些值得和大家分享的信息。以下，就是我本次的试玩体验。Ps：本次试玩为Demo版本，并不代表游戏上市后最终素质",
              maxLines: 7,
              style: TextStyle(
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
