import 'package:TapTap/common_widget/loading_diglog.dart';
import 'package:TapTap/common_widget/pinput_dialog.dart';
import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/service/user_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _checkBox = true;
  var _textController;
  String errMsg = "";

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
        backgroundColor: Colors.white,
        leading: InkWell(
          child: Icon(Icons.close),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Flexible(
                flex: 1000,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 180,
                        child: Image.asset(
                          "assets/images/login/login_taptap.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.1)),
                      height: 45,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 200,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text("CN+86"),
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            child: Container(
                              height: 25,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          Flexible(
                            flex: 460,
                            child: Container(
                              child: TextField(
                                controller: _textController,
                                onChanged: (value) {
                                  this.setState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: "请输入手机号码",
                                  contentPadding: EdgeInsets.fromLTRB(10, 17, 0,
                                      12), //输入框内容部分设置padding，跳转跟icon的对其位置
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 80,
                            child: InkWell(
                              onTap: () {
                                _textController.clear();
                              },
                              child: _textController.text.length > 0
                                  ? Icon(
                                      Icons.cancel,
                                      size: 20,
                                      color: Colors.grey,
                                    )
                                  : Container(),
                            ),
                          )
                        ],
                      ),
                    ),
                    errMsg.length > 0
                        ? Row(
                            children: [
                              SizedBox(
                                width: 45,
                              ),
                              Text(
                                errMsg,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 13),
                              ),
                            ],
                          )
                        : Container(),
                    Row(
                      children: [
                        SizedBox(
                          width: 45,
                        ),
                        Text(
                          "未注册用户验证后将自动注册并登陆",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 35, bottom: 5),
                        child: RawMaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () {
                            if (_textController.text == "") {
                              this.setState(() {
                                errMsg = "手机号码不能为空";
                              });
                              return;
                            }
                            //1.展示加载框
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return new LoadingDialog();
                                });
                            UserService.userLogin(_textController.text)
                                .then((value) {
                              if (value.code == 1) {
                                this.setState(() {
                                  errMsg = "";
                                });
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return PinPutDialog(
                                        phone: _textController.text,
                                        context: context,
                                      );
                                    });
                              } else {
                                this.setState(() {
                                  errMsg = value.message;
                                });
                                Navigator.pop(context);
                              }
                            });
                          },
                          elevation: 2.0,
                          fillColor: AppColors.navActive,
                          child: Text(
                            "登陆",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 138),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _checkBox = !_checkBox;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 5),
                            width: 15,
                            height: 15,
                            child: _checkBox
                                ? Center(
                                    child: FittedBox(
                                        child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  )))
                                : Container(),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.8),
                                ),
                                color: _checkBox
                                    ? AppColors.navActive
                                    : Colors.white),
                          ),
                        ),
                        Text(
                          "我已详细阅读并同意TapTap",
                          style: TextStyle(fontSize: 13),
                        ),
                        Text("服务协议",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          width: 1,
                        ),
                        Text("和", style: TextStyle(fontSize: 13)),
                        SizedBox(
                          width: 1,
                        ),
                        Text("隐私政策",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "老用户邮箱登陆",
                          style: TextStyle(
                              color: AppColors.navActive,
                              fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColors.navActive,
                            size: 19,
                          ),
                        )
                      ],
                    )
                  ],
                )),
            Flexible(
                flex: 601,
                child: Container(
                  color: Colors.white,
                )),
            Flexible(
                flex: 267,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            color: Colors.grey.withOpacity(0.5),
                            height: 0.7,
                          ),
                        ),
                        Text(
                          "社交账号登陆",
                          style: TextStyle(color: Colors.black),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            color: Colors.grey.withOpacity(0.5),
                            height: 0.7,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                "assets/images/login/login_wechat.png",
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              "微信",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        Column(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                "assets/images/login/login_qq.png",
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              "QQ",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
