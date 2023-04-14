import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme {
  final ThemeData themeData;

  AppTheme(this.themeData);

  factory AppTheme.darkTheme() {
    return AppTheme(
      ThemeData(
        appBarTheme: AppBarTheme(
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
          color: Colors.black38, // 更改Card的颜色
        ),

        dialogBackgroundColor: Colors.black12,
        //更改弹窗颜色
        popupMenuTheme: const PopupMenuThemeData(
            //更改按钮弹窗颜色
            color: Colors.black38),

        inputDecorationTheme: InputDecorationTheme(
          //更改输入框颜色
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey[700]!),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),

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
          background: Colors.black38,
          error: Colors.redAccent[700]!,
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
}

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = ThemeData.light();

  final String _selectedThemeKey = 'selected_theme';

  ThemeData get themeData => _themeData;

  ThemeProvider() {
    _loadSelectedTheme();
  }

  Future<void> setThemeData(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();

    // Save selected theme to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_selectedThemeKey, _themeData.hashCode);
  }

  void _loadSelectedTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? selectedThemeHash = prefs.getInt(_selectedThemeKey);

    if (selectedThemeHash != null) {
      _themeData = _getThemeFromHash(selectedThemeHash);
      notifyListeners();
    }
  }

  ThemeData _getThemeFromHash(int hashCode) {
    if (hashCode == ThemeData.light().hashCode) {
      return ThemeData.light();
    } else {
      return AppTheme.darkTheme().themeData;
    }
  }
}
