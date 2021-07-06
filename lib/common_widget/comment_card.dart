import 'package:TapTap/common_widget/loading_diglog.dart';
import 'package:TapTap/entity/comment_entity.dart';
import 'package:TapTap/pages/index/home/comment_page/comment_detail.dart';
import 'package:TapTap/service/comment_service.dart';
import 'package:TapTap/util/DigitUtil.dart';
import 'package:TapTap/util/DrawUtil.dart';
import 'package:TapTap/util/GlobalData.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommentCard extends StatefulWidget {
  final Comment comment;
  Function? callback;
  CommentCard({Key? key, required this.comment, this.callback})
      : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
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
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CommentDetailPage(comment: widget.comment)));
        },
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
                        widget.comment.userCoverUrl!.length == 0
                            ? "https://img0.baidu.com/it/u=1514002029,2035215441&fm=26&fmt=auto&gp=0.jpg"
                            : widget.comment.userCoverUrl!,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
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
                        widget.comment.userNickName!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(widget.comment.commentTime!,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          )),
                    ],
                  ),
                  Spacer(),
                  Spacer(),
                  InkWell(
                    child: DropdownButton(
                      // 默认提示文本
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      underline: Container(),
                      icon: Icon(Icons.more_vert),
                      dropdownColor: Colors.white.withOpacity(0.6),
                      items: GlobalData.userInfo != null
                          ? [
                              DropdownMenuItem(
                                child: Text("修改"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text("删除"),
                                value: 2,
                              ),
                              DropdownMenuItem(
                                child: Text("分享"),
                                value: 3,
                              ),
                            ]
                          : [
                              DropdownMenuItem(
                                child: Text("分享"),
                                value: 3,
                              ),
                              DropdownMenuItem(
                                child: Text("投诉"),
                                value: 1,
                              ),
                            ],
                      onChanged: (e) {
                        if (e == 2) {
                          if (widget.callback != null) widget.callback!();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                  children: DrawUtil.getStarOnly(widget.comment.commentScore!)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, bottom: 1),
              child: Text(
                widget.comment.commentDetail!,
                maxLines: 7,
                style: TextStyle(
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, right: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(),
                    flex: 8,
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    child: Center(
                      child: Image.asset("assets/images/home/share.png"),
                    ),
                  ),
                  Flexible(flex: 1, child: Container()),
                  Icon(
                    Icons.comment_bank,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(DigitUtil.getRandom().toString()),
                  ),
                  Flexible(flex: 1, child: Container()),
                  Icon(Icons.thumb_up, color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(DigitUtil.getRandom().toString()),
                  ),
                  Flexible(flex: 1, child: Container()),
                  Icon(Icons.thumb_down_rounded, color: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
