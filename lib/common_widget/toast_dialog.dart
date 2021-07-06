import 'package:flutter/material.dart';

class ToastDialog extends Dialog {
  final String toast;

  ToastDialog(this.toast);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(
          right: 60,
          left: 60,
          top: MediaQuery.of(context).size.height * 3.1 / 7,
          bottom: MediaQuery.of(context).size.height * 3.1 / 7),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(8),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning,
                color: Colors.yellow,
              ),
              Text(
                toast,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
