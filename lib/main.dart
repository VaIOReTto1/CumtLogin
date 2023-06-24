import 'package:bot_toast/bot_toast.dart';
import 'package:cumt_login/UrlPage/url_page.dart';
import 'package:cumt_login/config.dart';
import 'package:cumt_login/settings/settings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

import 'UrlPage/welcomeback.dart';
import 'icon.dart';
import 'loginpage.dart';
import 'settings/theme/theme_color.dart';
import 'login_util/prefs.dart';



main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //使用firebase统计
  await Firebase.initializeApp();

  await Prefs.init();
  runApp((MultiProvider(
    providers: [
      //用于主题切换
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ],
    child: const MyApp(),
  )));
  BotToastInit();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(UIConfig.designWidth, UIConfig.designHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          //主题切换
          theme: Provider.of<ThemeProvider>(context).themeData,
          //darkTheme: AppTheme.darkTheme().themeData,
          debugShowCheckedModeBanner: false,
          home: child,
          builder: BotToastInit(),
          //toast弹窗的初始化
          navigatorObservers: [BotToastNavigatorObserver()],
        );
      },
      //判断是否选择学校
      child: Prefs.school == '' ? const WelcomePage() : HomePage(),
    );
  }
}

//跳转HomePage函数
toHomePage(BuildContext context, int currentPageIndex) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => HomePage(
      currentPageIndex: currentPageIndex,
    ),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class HomePage extends StatefulWidget {
  int currentPageIndex; // 默认中间子组件
  HomePage({Key? key, this.currentPageIndex = 0}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(alignment: Alignment.center, children: [
        IndexedStack(
          index: widget.currentPageIndex,
          children: const [
            LoginPage(),
            SettingPage(),
            UrlPage(),
          ],
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.052,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).colorScheme.primary,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).brightness != Brightness.dark
                      ? const Color.fromRGBO(59, 114, 217, 0.2)
                      : Colors.black38,
                  spreadRadius: 4,
                  blurRadius: 8,
                  offset: const Offset(0,10.0), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(MyIcons.layer,
                          color: widget.currentPageIndex == 2
                              ? const Color.fromRGBO(44, 44, 44, 1)
                              : const Color.fromRGBO(111, 111, 111, 1),
                          size: 32),
                      onPressed: () {
                        setState(() {
                          widget.currentPageIndex = 2;
                        });
                      },
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 38,),
                        Text(
                          '    常用',
                          style: TextStyle(
                            fontSize: 13,
                            color: widget.currentPageIndex == 0
                                ? const Color.fromRGBO(44, 44, 44, 1)
                                : const Color.fromRGBO(111, 111, 111, 1),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: widget.currentPageIndex == 1
                            ? const Color.fromRGBO(44, 44, 44, 1)
                            : const Color.fromRGBO(111, 111, 111, 1),
                        size: 32,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.currentPageIndex = 1;
                        });
                      },
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 38,),
                        Text(
                          '   设置',
                          style: TextStyle(
                            fontSize: 13,
                            color: widget.currentPageIndex == 0
                                ? const Color.fromRGBO(44, 44, 44, 1)
                                : const Color.fromRGBO(111, 111, 111, 1),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.044,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: widget.currentPageIndex == 0
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).cardTheme.color,
                  shape: BoxShape.circle,
                ),
              ),
              Center(
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(59, 114, 217, 1),
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(MyIcons.net,
                            color: widget.currentPageIndex == 0
                                ? Colors.white
                                : const Color.fromRGBO(111, 111, 111, 1),
                            size: 32),
                        onPressed: () {
                          setState(() {
                            widget.currentPageIndex = 0;
                          });
                        },
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 40,),
                    Text(
                      '  登录',
                      style: TextStyle(
                        fontSize: 13,
                        color: widget.currentPageIndex == 0
                            ? Colors.white
                            : const Color.fromRGBO(111, 111, 111, 1),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}


