import 'package:TapTap/config/app_colors.dart';
import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  final String content;
  final bool positive;
  final int? numCount;
  const TagWidget(
      {Key? key, required this.content, required this.positive, this.numCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
                color: positive ? Colors.white : Colors.grey.withOpacity(0.1),
                border:
                    Border.all(width: 1, color: Colors.grey.withOpacity(0.3)),
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(5), right: Radius.circular(5))),
            child: Row(
              children: [
                Text(
                  content,
                  style: TextStyle(
                      color: positive ? AppColors.navActive : Colors.grey),
                ),
                SizedBox(
                  width: 1,
                ),
                Text(
                  numCount != null ? numCount.toString() : "",
                  style: TextStyle(
                      color: positive ? AppColors.navActive : Colors.grey),
                ),
              ],
            ))
      ],
    );
  }
}
