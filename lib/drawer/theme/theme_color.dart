import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData themeData;

  AppTheme(this.themeData);

  factory AppTheme.greenTheme() {
    return AppTheme(
      ThemeData(
        cardTheme: CardTheme(
          color: Colors.green[300]!, // 更改Card的颜色
        ),

        dialogBackgroundColor: Colors.green[100], //更改弹窗颜色
        popupMenuTheme: PopupMenuThemeData(  //更改按钮弹窗颜色
          color:Colors.green[300]
        ),

        inputDecorationTheme: InputDecorationTheme( //更改输入框颜色
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent[400]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent[700]!),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green[300]!),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),

          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              side: MaterialStateProperty.all(BorderSide(color: Colors.green)), //更改边框颜色
              foregroundColor: MaterialStateProperty.all(Colors.green),  //更改按钮字体颜色
            ),
          ),


        scaffoldBackgroundColor: Colors.green[100],  //更改页面顶端颜色
        canvasColor: Colors.green[100],
        //更改绘图颜色
        colorScheme: ColorScheme(
          primary: Colors.green[300]!, //更改页面顶端，按钮字体颜色
          secondary: Colors.greenAccent[400]!,
          background: Colors.green[100]!,
          error: Colors.redAccent[700]!,
          brightness: Brightness.light,
          onBackground: Colors.green[300]!,
          onError: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.green[300]!,
          onSurface: Colors.green[300]!,
          surface: Colors.green[50]!,
        ),
      ),
    );
  }

  factory AppTheme.blueTheme() {
    return AppTheme(
        ThemeData(
            cardTheme: CardTheme(
              color: Colors.blue[300]!, // 更改Card的颜色
            ),

            dialogBackgroundColor: Colors.blue[100],
            popupMenuTheme: PopupMenuThemeData(
                color:Colors.blue[300]
            ),

            inputDecorationTheme: InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent[400]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent[700]!),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue[300]!),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),

            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                side: MaterialStateProperty.all(BorderSide(color: Colors.blue)), //更改边框颜色
                foregroundColor: MaterialStateProperty.all(Colors.blue),  //更改按钮字体颜色
              ),
            ),

            scaffoldBackgroundColor: Colors.blue[100],
            canvasColor: Colors.blue[100],

            colorScheme: ColorScheme(
                primary: Colors.blue[300]!,
                secondary: Colors.blueAccent[400]!,
                background: Colors.blue[100]!,
                error: Colors.redAccent[700]!,
                brightness: Brightness.light,
                onBackground: Colors.blue[300]!,
                onError: Colors.white,
                onPrimary: Colors.white,
                onSecondary: Colors.blue[300]!,
                onSurface: Colors.blue[300]!,
                surface: Colors.blue[50]!)));
  }

  factory AppTheme.redTheme() {
    return AppTheme(
        ThemeData(
            cardTheme: CardTheme(
              color: Colors.red[300]!, // 更改Card的颜色
            ),

            inputDecorationTheme: InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.redAccent[400]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.redAccent[700]!),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red[300]!),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),

            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                side: MaterialStateProperty.all(BorderSide(color: Colors.red)), //更改边框颜色
                foregroundColor: MaterialStateProperty.all(Colors.red),  //更改按钮字体颜色
              ),
            ),

            dialogBackgroundColor: Colors.red[100],
            popupMenuTheme: PopupMenuThemeData(
                color:Colors.red[300]
            ),

            scaffoldBackgroundColor: Colors.red[100],
            canvasColor: Colors.red[100],

            colorScheme: ColorScheme(
                primary: Colors.red[300]!,
                secondary: Colors.red[400]!,
                background: Colors.red[100]!,
                error: Colors.redAccent[700]!,
                brightness: Brightness.light,
                onBackground: Colors.red[300]!,
                onError: Colors.white,
                onPrimary: Colors.white,
                onSecondary: Colors.red[300]!,
                onSurface: Colors.red[300]!,
                surface: Colors.red[50]!)));
  }

  factory AppTheme.yellowTheme() {
    return AppTheme(
        ThemeData(
            cardTheme: CardTheme(
              color: Colors.yellow[300]!, // 更改Card的颜色
            ),

            dialogBackgroundColor: Colors.yellow[100],
            popupMenuTheme: PopupMenuThemeData(
                color:Colors.yellow[300]
            ),

            inputDecorationTheme: InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellowAccent[400]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellowAccent[700]!),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow[300]!),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),

            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                side: MaterialStateProperty.all(BorderSide(color: Colors.yellow)), //更改边框颜色
                foregroundColor: MaterialStateProperty.all(Colors.yellow[700]!),  //更改按钮字体颜色
              ),
            ),

            scaffoldBackgroundColor: Colors.yellow[100],
            canvasColor: Colors.yellow[100],

            colorScheme: ColorScheme(
                primary: Colors.yellow[300]!, //更改页面顶端，按钮字体颜色
                secondary: Colors.yellow[400]!,
                background: Colors.yellow[100]!,
                error: Colors.yellowAccent[700]!,
                brightness: Brightness.light,
                onBackground: Colors.yellow[300]!,
                onError: Colors.white,
                onPrimary: Colors.white,
                onSecondary: Colors.yellow[300]!,
                onSurface: Colors.yellow[300]!,
                surface: Colors.yellow[50]!)));
  }

  factory AppTheme.greyTheme() {
    return AppTheme(
        ThemeData(
            cardTheme: CardTheme(
              color: Colors.grey[300]!, // 更改Card的颜色
            ),

            dialogBackgroundColor: Colors.grey[100],
            popupMenuTheme: PopupMenuThemeData(
                color:Colors.grey[300]
            ),

            inputDecorationTheme: InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[400]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[700]!),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),

            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                side: MaterialStateProperty.all(BorderSide(color: Colors.grey)), //更改边框颜色
                foregroundColor: MaterialStateProperty.all(Colors.grey),  //更改按钮字体颜色
              ),
            ),

            scaffoldBackgroundColor: Colors.grey[100],
            canvasColor: Colors.grey[100],

            colorScheme: ColorScheme(
                primary: Colors.grey[300]!,
                secondary: Colors.grey[400]!,
                background: Colors.grey[100]!,
                error: Colors.blueGrey[700]!,
                brightness: Brightness.light,
                onBackground: Colors.grey[300]!,
                onError: Colors.white,
                onPrimary: Colors.white,
                onSecondary: Colors.grey[300]!,
                onSurface: Colors.grey[300]!,
                surface: Colors.grey[50]!)));
  }

  factory AppTheme.pinkTheme() {
    return AppTheme(
        ThemeData(
            cardTheme: CardTheme(
              color: Colors.pink[300]!, // 更改Card的颜色
            ),

            inputDecorationTheme: InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pinkAccent[400]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pinkAccent[700]!),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pink[300]!),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),

            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                side: MaterialStateProperty.all(BorderSide(color: Colors.pink)), //更改边框颜色
                foregroundColor: MaterialStateProperty.all(Colors.pink),  //更改按钮字体颜色
              ),
            ),

            dialogBackgroundColor: Colors.pink[100],
            popupMenuTheme: PopupMenuThemeData(
                color:Colors.pink[300]
            ),

            scaffoldBackgroundColor: Colors.pink[100],
            canvasColor: Colors.pink[100],

            colorScheme: ColorScheme(
                primary: Colors.pink[300]!,
                secondary: Colors.pink[400]!,
                background: Colors.pink[100]!,
                error: Colors.pink[700]!,
                brightness: Brightness.light,
                onBackground: Colors.pink[300]!,
                onError: Colors.white,
                onPrimary: Colors.white,
                onSecondary: Colors.pink[300]!,
                onSurface: Colors.pink[300]!,
                surface: Colors.pink[50]!)));
  }

  factory AppTheme.purpleTheme() {
    return AppTheme(
        ThemeData(
            cardTheme: CardTheme(
              color: Colors.purple[300]!, // 更改Card的颜色
            ),

            dialogBackgroundColor: Colors.purple[100],
            popupMenuTheme: PopupMenuThemeData(
                color:Colors.purple[300]
            ),

            inputDecorationTheme: InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purpleAccent[400]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purpleAccent[700]!),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple[300]!),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),

            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                side: MaterialStateProperty.all(BorderSide(color: Colors.purple)), //更改边框颜色
                foregroundColor: MaterialStateProperty.all(Colors.purple),  //更改按钮字体颜色
              ),
            ),

            scaffoldBackgroundColor: Colors.purple[100],
            canvasColor: Colors.purple[100],

            colorScheme: ColorScheme(
                primary: Colors.purple[300]!,
                secondary: Colors.purple[400]!,
                background: Colors.purple[100]!,
                error: Colors.purple[700]!,
                brightness: Brightness.light,
                onBackground: Colors.purple[300]!,
                onError: Colors.white,
                onPrimary: Colors.white,
                onSecondary: Colors.purple[300]!,
                onSurface: Colors.purple[300]!,
                surface: Colors.purple[50]!)));
  }
}