import 'package:bot_toast/bot_toast.dart';
import 'package:cumt_login/UrlPage/url_page.dart';
import 'package:cumt_login/config/config.dart';
import 'package:cumt_login/settings/settings.dart';
import 'package:cumt_login/settings/update/app_upgrade2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Login/LoginPage/loginpage.dart';
import 'Login/login_util/prefs.dart';
import 'welcomeback.dart';
import 'config/icon.dart';
import 'config/theme_color.dart';

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
          debugShowCheckedModeBanner: false,
          home: child,
          builder: BotToastInit(),
          //toast弹窗的初始化
          navigatorObservers: [BotToastNavigatorObserver()],
        );
      },
      //判断是否选择学校
      child: Prefs.school1 == '' ? const WelcomePage() : HomePage(),
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
  Color select_color = const Color.fromRGBO(44, 44, 44, 1);
  Color unselect_color = const Color.fromRGBO(111, 111, 111, 1);
  Color black_select_color = const Color.fromRGBO(244, 240, 244, 1);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //打开app后默认检查更新
    Update.checkNeedUpdate(context, auto: true).then((_) {
      if (Update.isUpDate == true && Update.isIgnore != true) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return UpgradeDialog();
            });
      }
    });
    _currentPageIndex = 1;
  }

  final List<Widget> _pages = [
    const UrlPage(),
    const LoginPage(),
    const SettingPage(),
  ];

  int _currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack( //使用IndexedStack作为body
        index: _currentPageIndex, //当前显示的子组件索引
        children: _pages, //子组件列表
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.09,
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          currentIndex: _currentPageIndex,
          onTap: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          selectedItemColor: Theme.of(context).brightness != Brightness.dark
              ? select_color
              : black_select_color ,
          unselectedItemColor: Theme.of(context).brightness != Brightness.dark
              ? unselect_color
              : unselect_color,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                MyIcons.layer,
                size: 32,
              ),
              label: '常用',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MyIcons.net,
                size: 32,
              ),
              label: '登录',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 32,
              ),
              label: '设置 ',
            ),
          ],
        ),
      ),
    );
  }
}
