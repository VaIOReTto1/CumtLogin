import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme {
  final ThemeData themeData;

  AppTheme(this.themeData);

  factory AppTheme.darkTheme() {
    return AppTheme(
      ThemeData(
        drawerTheme: DrawerThemeData(backgroundColor: Colors.grey.shade700),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            toolbarTextStyle: const TextTheme(
              //更改appbar标题颜色
              titleLarge: TextStyle(
                color: Colors.white,
              ),
            ).bodyMedium,
            titleTextStyle: const TextTheme(
              titleLarge: TextStyle(
                color: Colors.white,
              ),
            ).titleLarge),

        cardTheme: const CardTheme(
          color: Colors.black54, // 更改Card的颜色
        ),

        dialogBackgroundColor: Colors.black12,
        //更改弹窗颜色
        popupMenuTheme: const PopupMenuThemeData(
            //更改按钮弹窗颜色
            color: Colors.black38),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            side: MaterialStateProperty.all(BorderSide(color: Colors.black38)),
            //更改边框颜色
            foregroundColor:
                MaterialStateProperty.all(Colors.white60), //更改按钮字体颜色
          ),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black38))),

        scaffoldBackgroundColor: ThemeData.dark().cardColor,
        //更改页面顶端颜色
        canvasColor: Colors.black12,
        //更改绘图颜色
        colorScheme: ColorScheme(
          primary: Colors.white60,
          //Picker颜色
          secondary: Colors.black87,
          error: Colors.redAccent[700]!,
          background: Colors.grey[700]!,
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
          color: Color.fromRGBO(176, 250, 255, 0.75), // 更改Card的颜色
        ),

        dialogBackgroundColor: Colors.grey.shade300,
        //更改弹窗颜色
        popupMenuTheme: const PopupMenuThemeData(
          //更改按钮弹窗颜色
          color: Color.fromRGBO(235, 240, 251, 1),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            side: MaterialStateProperty.all(
                const BorderSide(color: Color.fromRGBO(59, 114, 217, 1))),
            //更改边框颜色
            foregroundColor:
                MaterialStateProperty.all(Colors.grey), //更改按钮字体颜色
          ),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(59, 114, 217, 1)))),

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
