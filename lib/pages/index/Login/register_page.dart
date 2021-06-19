import 'dart:async';

import 'package:TapTap/common_widget/loading_diglog.dart';
import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/pages/index/home/home_page.dart';
import 'package:TapTap/pages/index/index_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final String phone;
  const RegisterPage({Key? key, required this.phone}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _textController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "填写昵称",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        leading: InkWell(
          child: Icon(
            Icons.keyboard_arrow_left,
            size: 35,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: ClipOval(
                  child: Image.network(
                    "https://img2.baidu.com/it/u=1995235764,179833910&fm=26&fmt=auto&gp=0.jpg",
                    fit: BoxFit.cover,
                    width: 70,
                  ),
                ),
              ),
            ),
            Text(
              "昵称",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w600),
            ),
            TextField(
              cursorHeight: 20,
              controller: _textController,
              onChanged: (value) {
                this.setState(() {});
              },
              cursorColor: AppColors.navActive,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                hintText: "请输入昵称",
              ),
            ),
            Spacer(),
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: RawMaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    //1.展示加载框
                    showDialog(
                        context: context,
                        builder: (context) {
                          return new LoadingDialog();
                        });
                    Timer.periodic(Duration(seconds: 1), (timer) {
                      timer.cancel();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => IndexPage()),
                          (route) => false);
                    });
                  },
                  elevation: 2.0,
                  fillColor: _textController.text.length == 0
                      ? Colors.grey.withOpacity(0.05)
                      : AppColors.navActive,
                  child: Text(
                    "完成",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 138),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
