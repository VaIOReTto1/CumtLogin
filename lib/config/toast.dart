import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'config.dart';


void showToast(String text,
    {int duration = 3,bool bottom = false}) {
  // Toast.show(text, context,
  //     backgroundRadius: 5, gravity: gravity, duration: duration);
  BotToast.showSimpleNotification(
    title: text,
    align: bottom?const Alignment(0, 1):const Alignment(0, -0.99), // bottom为true时，显示在底部，否则显示在顶部
    titleStyle: TextStyle(fontSize: UIConfig.fontAlertText),
    hideCloseButton: true,
    borderRadius: UIConfig.borderRadiusEntry,
    duration: Duration(seconds: duration),
  );
}
