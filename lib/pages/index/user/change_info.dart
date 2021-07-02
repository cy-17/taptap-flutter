import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:TapTap/common_widget/loading_diglog.dart';
import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/entity/response.dart';
import 'package:TapTap/entity/user_info.dart';
import 'package:TapTap/service/user_service.dart';
import 'package:TapTap/util/GlobalData.dart';
import 'package:address_picker/address_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfoPage> {
  late TextEditingController _controller;
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

  var _nickNameController;
  var _profileController;
  var _phoneNumberController;
  String birthday = "2021-06-17 13:51:11";
  String sex = "请选取性别";
  String region = "请输入地址";
  late UserInfo? userInfo;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: DateTime.now().toString());
    _nickNameController = TextEditingController();
    _profileController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _initData();
  }

  _initData() {
    UserService.getUserInfo().then((value) {
      this.setState(() {
        if (value.userBirthday != null && value.userBirthday!.length > 0)
          _controller.text = value.userBirthday!;
        if (value.userProfile != null && value.userProfile!.length > 0)
          _profileController.text = value.userProfile!;
        else
          _profileController.text = "";
        if (value.region != null && value.region!.length > 0)
          region = value.region!;
        sex = value.sex != null
            ? value.sex == 1
                ? "男"
                : "女"
            : "男";
        if (value.userBirthday != null) birthday = value.userBirthday!;
        _nickNameController.text = GlobalData.userInfo!.userNickName!;
        _phoneNumberController.text = GlobalData.userInfo!.userPhoneNumber!;
      });
    });
  }

  showAlertDialog(BuildContext context) {
    //设置按钮
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    //设置对话框
    AlertDialog alert = AlertDialog(
      content: Text("修改成功"),
      actions: [
        okButton,
      ],
    );

    //显示对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            size: 40,
          ),
        ),
        title: Text("编辑资料"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Center(
                child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return new LoadingDialog();
                    });
                String imageUrl = GlobalData.userInfo!.userCoverUrl!;
                String path = "";
                try {
                  path = _image.path;
                } catch (e) {} finally {
                  if (path.length > 0) {
                    UserService.uploadFile(path).then((value) {
                      if (value.code != 1) {
                        Navigator.pop(context);
                      } else {
                        imageUrl = value.map['url'];
                        UserService.changgeInfo(
                                _phoneNumberController.text,
                                _nickNameController.text,
                                _profileController.text,
                                imageUrl,
                                sex == "男" ? 1 : 2,
                                region,
                                birthday)
                            .then((value) {
                          Navigator.pop(context);
                          showAlertDialog(context);
                        });
                      }
                    });
                  } else
                    UserService.changgeInfo(
                            _phoneNumberController.text,
                            _nickNameController.text,
                            _profileController.text,
                            imageUrl,
                            sex == "男" ? 1 : 2,
                            region,
                            birthday)
                        .then((value) {
                      Navigator.pop(context);

                      showAlertDialog(context);
                    });
                }
              },
              child: Text(
                "保存",
                style: TextStyle(color: AppColors.navActive, fontSize: 15),
              ),
            )),
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.grey.withOpacity(0.4),
            height: 170,
            child: Padding(
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
                                  GlobalData.userInfo!.userCoverUrl!,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                )
                              : Image.file(
                                  _image,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
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
                            Icons.camera,
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
          ),
          Padding(
            padding: EdgeInsets.all(
              10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("昵称", style: TextStyle(fontSize: 14)),
                TextField(
                  controller: _nickNameController,
                  decoration: InputDecoration(
                    hintText: GlobalData.userInfo!.userNickName!,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text("个人简介", style: TextStyle(fontSize: 14)),
                TextField(
                  controller: _profileController,
                  decoration: InputDecoration(
                    hintText: "输入一句话简介",
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text("生日", style: TextStyle(fontSize: 14)),
                DateTimePicker(
                  type: DateTimePickerType.dateTimeSeparate,
                  dateMask: 'd MMM, yyyy',
                  controller: _controller,
                  firstDate: DateTime(1999),
                  lastDate: DateTime(2100),
                  icon: Icon(Icons.event),
                  dateLabelText: 'Date',
                  timeLabelText: "Hour",
                  selectableDayPredicate: (date) {
                    if (date.weekday == 6 || date.weekday == 7) {
                      return false;
                    }
                    return true;
                  },
                  onChanged: (val) => setState(() => birthday = val),
                  validator: (val) {
                    setState(() => {});
                    return null;
                  },
                  onSaved: (val) => setState(() => birthday = val!),
                ),
                SizedBox(
                  height: 30,
                ),
                Text("性别", style: TextStyle(fontSize: 14)),
                InkWell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(sex, style: TextStyle(fontSize: 17)),
                          Spacer(),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width - 20,
                        color: Colors.black,
                      )
                    ],
                  ),
                  onTap: () {
                    showPicker(context);
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Text("地区", style: TextStyle(fontSize: 14)),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(region, style: TextStyle(fontSize: 17)),
                          Spacer(),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width - 20,
                        color: Colors.black,
                      )
                    ],
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => BottomSheet(
                            onClosing: () {},
                            builder: (context) => Container(
                                  height: 250.0,
                                  child: AddressPicker(
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                    mode: AddressPickerMode
                                        .provinceCityAndDistrict,
                                    onSelectedAddressChanged: (address) {
                                      this.setState(() {
                                        region =
                                            '${address.currentProvince.province}-' +
                                                '${address.currentCity.city}-' +
                                                '${address.currentDistrict.area}';
                                      });
                                    },
                                  ),
                                )));
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Text("手机号", style: TextStyle(fontSize: 14)),
                TextField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                      hintText: GlobalData.userInfo!.userPhoneNumber!),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey.withOpacity(0.3),
            height: 35,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 4),
              child: Text("实名认证"),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("真实姓名", style: TextStyle(fontSize: 14)),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("陈**", style: TextStyle(fontSize: 17)),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width - 20,
                      color: Colors.black,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text("身份证号码", style: TextStyle(fontSize: 14)),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("441624199911*****(已提交）",
                            style: TextStyle(fontSize: 17)),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width - 20,
                      color: Colors.black,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  final String _fontFamily = Platform.isWindows ? "Roboto" : "";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  showPicker(BuildContext context) {
    Picker picker = Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: JsonDecoder().convert(sexString)),
        changeToFirst: false,
        textAlign: TextAlign.left,
        textStyle: TextStyle(color: Colors.blue, fontFamily: _fontFamily),
        selectedTextStyle: TextStyle(color: Colors.red),
        columnPadding: const EdgeInsets.all(8.0),
        onConfirm: (Picker picker, List value) {
          this.setState(() {
            sex = picker
                .getSelectedValues()
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", "");
          });
          ;
        });
    picker.show(_scaffoldKey.currentState!);
  }

  String sexString = """["男","女"]""";
}
