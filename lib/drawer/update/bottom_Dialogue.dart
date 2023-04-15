import 'package:flutter/material.dart';

Future<void> show(BuildContext context, String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // 点击空白处是否关闭对话框
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[700],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    },
  );
}
