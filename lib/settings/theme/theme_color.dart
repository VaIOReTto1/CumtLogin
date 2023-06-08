import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme {
  final ThemeData themeData;

  AppTheme(this.themeData);

  factory AppTheme.darkTheme() {
    return AppTheme(
      ThemeData(
        cardTheme: CardTheme(
          color: Colors.grey[700], // 更改Card的颜色
        ),

        //更改snakbar颜色
        snackBarTheme: const SnackBarThemeData(
          backgroundColor:Colors.black54,//背景颜色
            contentTextStyle: TextStyle(color: Colors.white)//文字颜色
        ),

        dialogBackgroundColor: Colors.black12,
        //更改弹窗颜色
        popupMenuTheme: PopupMenuThemeData(
            //更改按钮弹窗颜色
            color: Colors.grey[700]),

        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.white),
            )),

        scaffoldBackgroundColor: ThemeData.dark().cardColor,
        //更改页面顶端颜色
        canvasColor: Colors.black12,
        //更改绘图颜色
        colorScheme: ColorScheme(
          primary: const Color.fromRGBO(50,50,50,1),
          //Picker颜色
          secondary: Colors.black87,
          error: Colors.redAccent[700]!,
          background: Colors.white60,
          brightness: Brightness.dark,
          onBackground: Colors.black38,
          onError: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.black38,
          onSurface: Colors.black38,
          surface: Colors.black12,
        ),
      ),
    );
  }

  factory AppTheme.LightTheme() {
    return AppTheme(
      ThemeData(
        cardTheme: const CardTheme(
          color: Color.fromRGBO(245,244,249,1),// 更改Card的颜色
        ),
        canvasColor: Color.fromRGBO(245,244,249,1),

        //更改snackbar颜色
        snackBarTheme: SnackBarThemeData(
          backgroundColor:Color.fromRGBO(176, 250, 255, 0.75),//背景颜色
          contentTextStyle: TextStyle(color: Colors.white)//文字颜色
        ),

        dialogBackgroundColor: Colors.grey.shade300,
        //更改弹窗颜色
        popupMenuTheme: const PopupMenuThemeData(
          //更改按钮弹窗颜色
          color: Color.fromRGBO(216, 227, 247, 1),
        ),

        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.black),
            )),

        colorScheme: ColorScheme(
          primary:Colors.white,
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
