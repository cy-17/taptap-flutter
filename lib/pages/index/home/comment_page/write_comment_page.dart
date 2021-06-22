import 'dart:async';
import 'dart:io';
import 'package:TapTap/common_widget/loading_diglog.dart';
import 'package:TapTap/config/app_colors.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WriteCommentPage extends StatefulWidget {
  const WriteCommentPage({Key? key}) : super(key: key);

  @override
  _WriteCommentPageState createState() => _WriteCommentPageState();
}

class _WriteCommentPageState extends State<WriteCommentPage> {
  String model = "未知型号";

  bool _switch = false;
  @override
  void initState() {
    super.initState();
    getDeviceInfo();
  }

  void getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      this.setState(() {
        model = iosInfo.utsname.machine;
      });
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      this.setState(() {
        model = androidInfo.model;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              CommentTopWidget(),
              SizedBox(
                height: 20,
              ),
              Row(children: [
                Text(
                  "请打分",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                Spacer(),
                Icon(
                  Icons.phone_android_outlined,
                  size: 20,
                ),
                SizedBox(
                  width: 1,
                ),
                Text(model),
              ]),
              SizedBox(
                height: 15,
              ),
              RatingBar(
                initialRating: 0, //初始评分 double
                itemCount: 5, //评分组件个数
                direction: Axis.horizontal,
                onRatingUpdate: (rating) {
                  setState(() {});
                },
                itemSize: 24,
                ratingWidget: RatingWidget(
                  half: Icon(
                    Icons.star,
                    color: AppColors.navActive,
                  ),
                  full: Icon(
                    Icons.star,
                    color: AppColors.navActive,
                  ),
                  empty: Icon(
                    Icons.star,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Expanded(
                  child: Container(
                child: TextField(
                  maxLines: null,
                  maxLength: 400,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "写下你的想法...",
                    border: InputBorder.none,
                  ),
                ),
              )),
              Row(children: [
                Icon(Icons.access_time),
                SizedBox(width: 10),
                Text(
                  "点击开启游戏时长统计",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                Spacer(),
                Switch(
                    value: _switch,
                    activeColor: AppColors.navActive,
                    onChanged: (value) {
                      this.setState(() {
                        _switch = value;
                      });
                    })
              ]),
              SizedBox(
                height: 10,
              ),
              Icon(Icons.tag_faces),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 5),
                  child: RawMaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      //1.展示加载框
                      showDialog(
                          context: context,
                          builder: (context) {
                            return new LoadingDialog();
                          });
                      Timer.periodic(Duration(seconds: 1), (timer) {
                        timer.cancel();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    },
                    elevation: 2.0,
                    fillColor: AppColors.navActive,
                    child: Text(
                      "发表",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 170),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentTopWidget extends StatelessWidget {
  const CommentTopWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.close,
          color: Colors.black,
          size: 30,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          "写评价",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        Spacer(),
        Icon(Icons.local_library_outlined),
        SizedBox(
          width: 5,
        ),
        Text(
          "草稿箱",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ],
    );
  }
}
