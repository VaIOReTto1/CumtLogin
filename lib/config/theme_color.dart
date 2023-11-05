import 'package:cumt_login/config/icon.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Login/login_util/prefs.dart';

class AppTheme {
  final ThemeData themeData;

  AppTheme(this.themeData);

  factory AppTheme.darkTheme() {
    return AppTheme(
      ThemeData(
        platform: TargetPlatform.iOS,

        cardTheme: CardTheme(
          color: Colors.grey[900], // 更改Card的颜色
        ),

        appBarTheme: const AppBarTheme(),
        textTheme: const TextTheme(),

        //更改snakbar颜色
        snackBarTheme: const SnackBarThemeData(
            backgroundColor: Colors.black54, //背景颜色
            contentTextStyle: TextStyle(color: Colors.white) //文字颜色
            ),

        dialogBackgroundColor: Colors.black12,
        //更改弹窗颜色
        popupMenuTheme: PopupMenuThemeData(
            //更改按钮弹窗颜色
            color: Colors.grey[850]),

        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.grey[700]),
          foregroundColor: const MaterialStatePropertyAll(Colors.white),
        )),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.grey[800]),
          foregroundColor: const MaterialStatePropertyAll(Colors.white),
        )),

        scaffoldBackgroundColor: Colors.black,
        canvasColor: Colors.grey[900],
        colorScheme: ColorScheme(
          primary: const Color(0xff25292e),
          secondary: Colors.grey[700]!,
          error: Colors.redAccent[700]!,
          background: Colors.black,
          brightness: Brightness.dark,
          onBackground: Colors.grey[500]!,
          onError: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.grey[500]!,
          onSurface: Colors.grey[500]!,
          surface: Colors.grey[900]!,
        ),
      ),
    );
  }

  factory AppTheme.LightTheme() {
    return AppTheme(
      ThemeData(
        platform: TargetPlatform.iOS,

        cardTheme: const CardTheme(
          color: Color.fromRGBO(245, 244, 249, 1), // 更改Card的颜色
        ),
        canvasColor: const Color.fromRGBO(245, 244, 249, 1),

        appBarTheme: const AppBarTheme(),
        textTheme: const TextTheme(),

        //更改snackbar颜色
        snackBarTheme: const SnackBarThemeData(
            backgroundColor: Color.fromRGBO(176, 250, 255, 0.75), //背景颜色
            contentTextStyle: TextStyle(color: Colors.white) //文字颜色
            ),

        dialogBackgroundColor: Colors.grey.shade300,
        //更改弹窗颜色
        popupMenuTheme: const PopupMenuThemeData(
          //更改按钮弹窗颜色
          color: Color.fromRGBO(216, 227, 247, 1),
        ),

        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(Color.fromRGBO(235, 240, 251, 1)),
          foregroundColor: MaterialStatePropertyAll(Colors.black),
        )),

        outlinedButtonTheme: const OutlinedButtonThemeData(
            style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(Color.fromRGBO(216, 227, 247, 1)),
          foregroundColor: MaterialStatePropertyAll(Colors.black),
        )),

        colorScheme: ColorScheme(
          primary: Colors.white,
          //Picker颜色
          secondary: Colors.white,
          background: Colors.white,
          error: Colors.redAccent[700]!,
          brightness: Brightness.light,
          onBackground: Colors.white,
          onError: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          surface: Colors.white,
        ),
      ),
    );
  }
}

class ThemeProvider with ChangeNotifier {
  static ThemeData _themeData = AppTheme.LightTheme().themeData;
  static Brightness _brightness = Brightness.light;
  static const String _themeKey = 'brightness';

  ThemeData get themeData => _themeData;

  ThemeProvider() {
    loadThemeData();
  }

  Future<void> saveThemeData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, _brightness == Brightness.light ? 1 : 0);
  }

  Future<void> setThemeData(ThemeData themeData) async {
    _themeData = themeData;
    _brightness = _themeData.brightness;
    notifyListeners();
    await saveThemeData();
  }

  Future<void> loadThemeData() async {
    final prefs = await SharedPreferences.getInstance();
    final int? isLight = prefs.getInt(_themeKey);
    if (isLight == null || isLight == 1) {
      _brightness = Brightness.light;
    } else {
      _brightness = Brightness.dark;
    }
    updateThemeData();
    notifyListeners();
  }

  void updateThemeData() {
    if (_brightness == Brightness.light) {
      _themeData = AppTheme.LightTheme().themeData;
    } else {
      _themeData = AppTheme.darkTheme().themeData;
    }
  }
}
