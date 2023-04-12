import 'package:cumt_login/drawer/theme/theme_button_ex.dart';
import 'package:cumt_login/drawer/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'ex.dart';

class ThemeButton extends StatefulWidget {
  ThemeButton({Key? key}) : super(key: key);

  static ThemeData themeData = ThemeData.light();

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ThemeColorButton(
              themeData: ThemeData.dark(),
              icon: Icons.dark_mode,
              color: Colors.black87),
          const SizedBox(
            width: 10,
          ),
          ThemeColorButton(
              themeData: ThemeData.light(),
              icon: Icons.sunny,
              color: Colors.orangeAccent),
          const SizedBox(
            width: 10,
          ),
          ThemeColorButton(
              themeData: AppTheme.greenTheme().themeData,
              icon: Icons.circle,
              color: Colors.greenAccent),
          const SizedBox(
            width: 10,
          ),
          ThemeColorButton(
              themeData: AppTheme.yellowTheme().themeData,
              icon: Icons.circle,
              color: Colors.yellowAccent),
          const SizedBox(
            width: 10,
          ),
          ThemeColorButton(
              themeData: AppTheme.greyTheme().themeData,
              icon: Icons.circle,
              color: Colors.blueGrey),
          const SizedBox(
            width: 10,
          ),
          ThemeColorButton(
              themeData: AppTheme.blueTheme().themeData,
              icon: Icons.circle,
              color: Colors.blueAccent),
          const SizedBox(
            width: 10,
          ),
          ThemeColorButton(
              themeData: AppTheme.redTheme().themeData,
              icon: Icons.circle,
              color: Colors.redAccent),
          const SizedBox(
            width: 10,
          ),
          ThemeColorButton(
              themeData: AppTheme.pinkTheme().themeData,
              icon: Icons.circle,
              color: Colors.pinkAccent),
          const SizedBox(
            width: 10,
          ),
          ThemeColorButton(
              themeData: AppTheme.purpleTheme().themeData,
              icon: Icons.circle,
              color: Colors.purpleAccent),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData=ThemeData.light();

  ThemeData get themeData => _themeData;


Future<void> setThemeData(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
    print(_themeData.toString());
}
}
