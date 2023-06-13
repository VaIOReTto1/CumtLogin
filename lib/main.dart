import 'package:bot_toast/bot_toast.dart';
import 'package:cumt_login/UrlPage/url_page.dart';
import 'package:cumt_login/config.dart';
import 'package:cumt_login/settings/drawer_button.dart';
import 'package:cumt_login/settings/settings.dart';
import 'package:cumt_login/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'UrlPage/welcomeback.dart';
import 'icon.dart';
import 'settings/theme/theme_color.dart';
import 'settings/update/app_upgrade2.dart';
import 'login_util/account.dart';
import 'login_util/login.dart';
import 'login_util/methods.dart';
import 'login_util/prefs.dart';

toLoginPage(BuildContext context) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => const LoginPage(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

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
    ThemeData getTheme() {
      if (Prefs.isDark == 'true')
        return MediaQuery.of(context).platformBrightness == Brightness.dark
            ? AppTheme.darkTheme().themeData
            : AppTheme.LightTheme().themeData;
      else
        return Provider.of<ThemeProvider>(context).themeData;
    }

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

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  late AnimationController _controller;
  late Animation<double> _animation;

  //日活统计
  Future<void> logLoginEvent() async {
    await analytics.logEvent(
      name: 'daily user count',
    );
  }

  @override
  void initState() {
    super.initState();
    ThemeProvider;
    logLoginEvent();
    WidgetsBinding.instance.addObserver(this);

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

    //登录页圆圈动画
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.7, end: 0.8).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //升起登录页时调低色彩
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  //登录页上部分
                  Container(
                    height: MediaQuery.of(context).size.height * 0.119,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                      color: Theme.of(context).colorScheme.primary,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness != Brightness.dark
                              ? const Color.fromRGBO(59, 114, 217, 0.2)
                              : Colors.black38,
                          spreadRadius: 12,
                          blurRadius: 18,
                          offset: Offset.zero, // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(child: Container()),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '    ${Prefs.school}',
                                style: TextStyle(
                                  fontSize: UIConfig.fontSizeTitle * 1.2,
                                  color: Color.fromRGBO(59, 114, 217, 1),
                                ),
                              ),
                            ),
                            HelpButton(),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0105,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.19,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromRGBO(246, 246, 246, 1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 3, 15, 3),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle_sharp,
                            color: Color.fromRGBO(59, 114, 217, 1),
                            size: 7,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Prefs.status == '1'
                              ? Text(
                                  '已连接    ',
                                  style: TextStyle(
                                      color: Color.fromRGBO(161, 161, 161, 1),
                                      fontSize: 12),
                                )
                              : Text(
                                  '未连接    ',
                                  style: TextStyle(
                                      color: Color.fromRGBO(161, 161, 161, 1),
                                      fontSize: 12),
                                ),
                        ],
                      ),
                    ),
                  )),
              //登录页中间部分（圆圈动画
              Stack(
                children: [
                  //周围圆环动画
                  Center(
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (BuildContext context, Widget? child) {
                        return Container(
                          width: MediaQuery.of(context).size.height *
                              0.29 *
                              _animation.value,
                          height: MediaQuery.of(context).size.height *
                              0.29 *
                              _animation.value,
                          decoration: BoxDecoration(
                            color: Prefs.status == '1'
                                ? Color.fromRGBO(
                                    66, 128, 237, 0.4 - (_animation.value / 5))
                                : Color.fromRGBO(
                                    234, 234, 234, 1 - (_animation.value / 5)),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Prefs.status == '1'
                                    ? Color.fromRGBO(66, 128, 237, 0.15)
                                    : Color.fromRGBO(234, 234, 234, 1),
                                spreadRadius: 10 * _animation.value,
                                blurRadius: 30 * _animation.value,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  //中间圆圈
                  Center(
                    child: IgnorePointer(
                      child: Container(
                        width: MediaQuery.of(context).size.height * 0.2,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Prefs.status == '1'
                              ? Color.fromRGBO(59, 114, 217, 1)
                              : Color.fromRGBO(161, 161, 161, 1),
                        ),
                        child: Icon(
                          MyIcons.link,
                          size: MediaQuery.of(context).size.height * 0.096,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //登录栏
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.15,
                child: InkWell(
                  onTap: () {
                    _loginpage();
                  },
                  child: const Icon(Icons.keyboard_arrow_up_rounded,
                      color: Color.fromRGBO(59, 114, 217, 1),
                      size: 40,
                      shadows: <Shadow>[
                        Shadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius: 10.0,
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loginpage() {
    //底部跳出边框
    showModalBottomSheet(
        isScrollControlled: true,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.73,
            child: const Login(),
          );
        });
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
                  offset: Offset(0,10.0), // changes position of shadow
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
                        SizedBox(height: 38,),
                        Text(
                          '    常用',
                          style: TextStyle(
                            fontSize: 13,
                            color: widget.currentPageIndex == 0
                                ? Colors.white
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
                        SizedBox(height: 38,),
                        Text(
                          '   设置',
                          style: TextStyle(
                            fontSize: 13,
                            color: widget.currentPageIndex == 0
                                ? Colors.white
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
              Container(
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
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 40,),
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

//登陆栏
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  CumtLoginAccount cumtLoginAccount = CumtLoginAccount();

  bool border = true;
  bool isobscureText = true;

  @override
  void initState() {
    super.initState();
    ThemeProvider;
    _usernameController.text = cumtLoginAccount.username!;
    _passwordController.text = cumtLoginAccount.password!;
    if (_usernameController.text.isNotEmpty) {
      _handleLogin(context);
    }
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 在resumed的时候自动登录校园网
    if (state == AppLifecycleState.resumed) {
      _handleLogin(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          children: [
            Column(children: [
              const SizedBox(
                height: 55,
              ),
              buildTextField("账号", _usernameController, showPopButton: true),
            ]),
            const SizedBox(height: 16.0),
            Column(children: [
              const SizedBox(
                height: 5,
              ),
              buildTextField(
                "密码",
                _passwordController,
                obscureText: true,
              ),
            ]),
            const SizedBox(height: 16.0),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.208,
                ),
                const Text(
                  '选择运营商：',
                  style: TextStyle(
                      color: Color.fromRGBO(112, 112, 112, 1), fontSize: 14),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.048,
                ),
                TextButton(
                    onPressed: () => _showLocationMethodPicker(),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(Size(
                          MediaQuery.of(context).size.width * 0.355,
                          MediaQuery.of(context).size.height * 0.047)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(235, 240, 251, 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text("${cumtLoginAccount.cumtLoginMethod?.name}"),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // ElevatedButton(
            //   onPressed: () => _handleLogin(context),
            //   child: Text('登录',
            //       style: TextStyle(fontSize: UIConfig.fontSizeMain)),
            // ),
            // OutlinedButton(
            //   onPressed: () => _handleLogout(context),
            //   child: Text('注销',
            //       style: TextStyle(fontSize: UIConfig.fontSizeMain)),
            // ),
          ],
        ),
      ),
    );
  }

  //运营商选择
  void _showLocationMethodPicker() {
    Picker(
      adapter: PickerDataAdapter<dynamic>(
        pickerData: [CumtLoginMethodExtension.nameList],
        isArray: true,
      ),
      changeToFirst: true,
      hideHeader: false,
      onConfirm: (Picker picker, List value) {
        setState(() {
          cumtLoginAccount
              .setCumtLoginMethodByName(picker.getSelectedValues()[0]);
        });
      },
      cancelTextStyle: const TextStyle(color: Colors.black),
      confirmTextStyle: const TextStyle(color: Colors.black),
    ).showModal(context);
  }

  //输入框设置
  Widget buildTextField(
      String labelText, TextEditingController textEditingController,
      {showPopButton = false, obscureText = false}) {
    return Stack(
      alignment: obscureText ? Alignment.center : Alignment.centerRight,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.66,
          height: MediaQuery.of(context).size.height * 0.047,
          decoration: BoxDecoration(
            borderRadius: showPopButton
                ? border
                    ? BorderRadius.circular(10)
                    : const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )
                : BorderRadius.circular(10),
            color: const Color.fromRGBO(235, 240, 251, 1),
          ),
          child: Row(
            children: [
              if (!obscureText)
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.circle,
                    color: Colors.white,
                  ),
                ),
              if (!obscureText)
                const VerticalDivider(
                  thickness: 1,
                  color: Color.fromRGBO(59, 114, 217, 1),
                  width: 16,
                ),
              Expanded(
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  controller: textEditingController,
                  obscureText: isobscureText && obscureText,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide.none,
                    ),
                    labelText: labelText,
                    labelStyle: const TextStyle(
                        color: Color.fromRGBO(191, 191, 191, 1)),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: obscureText
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                isobscureText = !isobscureText;
                              });
                            },
                            child: Icon(
                              isobscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color.fromRGBO(59, 114, 217, 1),
                              size: 19,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
        //多账号选择
        showPopButton
            ? PopupMenuButton<CumtLoginAccount>(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                elevation: 0,
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.66 - 40,
                  maxWidth: MediaQuery.of(context).size.width * 0.66 - 40,
                ),
                color: const Color.fromRGBO(216, 227, 247, 1),
                offset:
                    Offset(0, MediaQuery.of(context).size.height * 0.047 + 4),
                icon: const Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Color.fromRGBO(59, 114, 217, 1),
                  size: 30,
                ),
                onOpened: () {
                  setState(() {
                    border = !border;
                  });
                  FocusScope.of(context).unfocus();
                },
                onCanceled: () {
                  setState(() {
                    !border ? border = !border : null;
                  });
                },
                onSelected: (account) {
                  setState(() {
                    border = !border;
                    cumtLoginAccount = account.clone();
                    _usernameController.text = cumtLoginAccount.username!;
                    _passwordController.text = cumtLoginAccount.password!;
                  });
                },
                itemBuilder: (context) {
                  return CumtLoginAccount.list.map((account) {
                    return PopupMenuItem<CumtLoginAccount>(
                      value: account,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${account.username}"
                              " ${account.cumtLoginMethod?.name}",
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                CumtLoginAccount.removeList(account);
                                showSnackBar(context, "删除成功");
                                Navigator.of(context).pop();
                                border = !border;
                              },
                              icon: const Icon(Icons.close))
                        ],
                      ),
                    );
                  }).toList();
                })
            : Container()
      ],
    );
  }

//注销
  void _handleLogout(BuildContext context) {
    CumtLogin.logout(account: cumtLoginAccount).then((value) {
      showSnackBar(context, value);
    });
  }

  //登录
  void _handleLogin(BuildContext context) {
    if (_usernameController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      showSnackBar(context, '账号或密码不能为空');
      return;
    }
    cumtLoginAccount.username = _usernameController.text.trim();
    cumtLoginAccount.password = _passwordController.text.trim();

    CumtLogin.login(account: cumtLoginAccount).then((value) {
      setState(() {
        showSnackBar(context, value);
      });
    });
  }
}
