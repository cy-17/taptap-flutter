import 'dart:async';

import 'package:TapTap/config/app_colors.dart';
import 'package:TapTap/pages/index/login/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pinput/pin_put/pin_put.dart';

import 'loading_diglog.dart';

class PinPutDialog extends StatefulWidget {
  final String phone;
  const PinPutDialog({Key? key, required this.phone}) : super(key: key);

  @override
  _PinPutDialogState createState() => _PinPutDialogState();
}

class _PinPutDialogState extends State<PinPutDialog> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  late Timer _timer;
  int _time = 60;

  @override
  void dispose() {
    super.dispose();
    if (mounted) {
      _timer.cancel();
      _pinPutController.clear();
    }
  }

  @override
  void initState() {
    if (mounted) {
      super.initState();
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        this.setState(() {
          _time--;
          if (_time == 0) timer.cancel();
        });
      });
    }
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            height: 220,
            margin: const EdgeInsets.all(25.0),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "请输入验证码",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    InkWell(
                      child: Icon(
                        Icons.close,
                      ),
                      onTap: () {
                        Navigator.pop(
                          context,
                        );
                      },
                    )
                  ],
                ),
                Text("短信验证码已发送至+86 ${widget.phone}"),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 30),
                  child: PinPut(
                      fieldsCount: 6,
                      eachFieldWidth: 30,
                      eachFieldHeight: 50,
                      onSubmit: (String pin) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return new LoadingDialog();
                            });
                        _timer.cancel();
                        Timer.periodic(Duration(seconds: 1), (timer) {
                          timer.cancel();
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RegisterPage(phone: widget.phone)));
                        });
                      },
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      submittedFieldDecoration: _pinPutDecoration,
                      selectedFieldDecoration: _pinPutDecoration,
                      followingFieldDecoration: _pinPutDecoration),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "$_time",
                      style: TextStyle(
                          color: AppColors.navActive,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Text(
                      "秒后可重新发送",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
