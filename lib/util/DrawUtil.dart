import 'package:TapTap/config/app_colors.dart';
import 'package:flutter/material.dart';

class DrawUtil {
  static List<Widget> getStar(int count, int particalCount, int totalCount) {
    List<Widget> list = List.generate(
        count,
        (index) => Icon(
              Icons.star,
              size: 15,
              color: Colors.grey.withOpacity(0.5),
            ));

    list.add(Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 2),
      child: Container(
        width: 150,
        child: Row(
          children: [
            Flexible(
                flex: particalCount,
                child: Container(
                  height: 5,
                  color: AppColors.navActive,
                )),
            Flexible(
                flex: totalCount - particalCount,
                child:
                    Container(height: 5, color: Colors.grey.withOpacity(0.4)))
          ],
        ),
      ),
    ));
    return list;
  }

  static List<Widget> getStarOnly(int count) {
    List<Widget> list = List.generate(
        count,
        (index) => Icon(
              Icons.star,
              size: 15,
              color: AppColors.navActive,
            ));

    return list;
  }

  static showAlertDialog(BuildContext context, String content) {
    //设置按钮
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    //设置对话框
    AlertDialog alert = AlertDialog(
      content: Text(content),
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
}
