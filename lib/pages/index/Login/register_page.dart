import 'dart:async';
import 'dart:io';

import 'package:TapTap/common_widget/loading_diglog.dart';
import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/entity/user_info.dart';
import 'package:TapTap/service/user_service.dart';
import 'package:TapTap/util/GlobalData.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  final String phone;
  const RegisterPage({Key? key, required this.phone}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _textController;
  late File _image;
  final picker = ImagePicker();
  bool _visible = true;
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _visible = false;
      } else {
        print('No image selected.');
      }
    });
  }

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "填写昵称",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
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
                child: Stack(
                  children: [
                    ClipOval(
                      child: InkWell(
                        onTap: () {
                          getImage();
                        },
                        child: Container(
                          child: _visible
                              ? Image.network(
                                  "https://img2.baidu.com/it/u=1995235764,179833910&fm=26&fmt=auto&gp=0.jpg",
                                  fit: BoxFit.cover,
                                  width: 70,
                                  height: 70,
                                )
                              : Image.file(
                                  _image,
                                  fit: BoxFit.cover,
                                  width: 70,
                                  height: 70,
                                ),
                        ),
                      ),
                    ),
                    ClipOval(
                      child: Container(
                        width: 30,
                        height: 30,
                        color: Color.fromRGBO(246, 247, 249, 1),
                        child: Center(
                          child: Icon(
                            Icons.create,
                            color: AppColors.navActive,
                          ),
                        ),
                      ),
                    )
                  ],
                  alignment: Alignment.bottomRight,
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
                    if (_visible) {
                      UserInfo userInfo = UserInfo(
                          _textController.text,
                          widget.phone,
                          "https://img2.baidu.com/it/u=1995235764,179833910&fm=26&fmt=auto&gp=0.jpg");
                      UserService.register(userInfo).then((value) {
                        if (value.code == 1) {
                          this.setState(() {
                            Timer.periodic(Duration(seconds: 2), (timer) {
                              timer.cancel();
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                          });
                        }
                      });
                    } else {
                      UserService.uploadFile(_image.path).then((value) {
                        if (value.code != 1) {
                          Navigator.pop(context);
                        } else {
                          UserInfo userInfo = UserInfo(_textController.text,
                              widget.phone, value.map['url']);
                          UserService.register(userInfo).then((value) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                        }
                      });
                    }
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
