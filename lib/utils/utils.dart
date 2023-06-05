import 'package:flutter/material.dart';

//显示按钮
void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color.fromRGBO(176, 250, 255, 0.75),
        content: Text(message,style: const TextStyle(color: Colors.white),),
        duration: const Duration(seconds: 1),
  ));
}