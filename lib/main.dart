import 'package:bot_toast/bot_toast.dart';
import 'package:cumt_login/UrlPage/url_page.dart';
import 'package:cumt_login/config.dart';
import 'package:cumt_login/settings/drawer_button.dart';
import 'package:cumt_login/settings/settings.dart';
import 'package:cumt_login/utils/utils.dart';
import 'package:cumt_login/welcome.dart';

import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

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
  await Firebase.initializeApp();

  await Prefs.init();
  runApp((MultiProvider(
    providers: [
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
          theme: Provider.of<ThemeProvider>(context).themeData,
          debugShowCheckedModeBanner: false,
          home: child,
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
        );
      },
      child: Prefs.school == '' ? WelComePage() : HomePage(),
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

  Future<void> logLoginEvent() async {
    await analytics.logEvent(
      name: 'daily user count',
    );
  }

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    ThemeProvider;
    logLoginEvent();
    WidgetsBinding.instance.addObserver(this);
    // checkUpgrade(context);      //打开app后默认检查更新

    //Update.initCheckUpdate(context,auto: true);

    Update.checkNeedUpdate(context, auto: true).then((_) {
      if (Update.isUpDate == true && Update.isIgnore != true) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return UpgradeDialog();
            });
      }
    });

    // 创建动画控制器
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    // 创建动画
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
        backgroundColor: isExpanded
            ? const Color.fromRGBO(128, 128, 128, 0.5)
            : Theme.of(context).colorScheme.primary,
        body: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.119,
                    decoration: BoxDecoration(
                      color: isExpanded
                          ? const Color.fromRGBO(128, 128, 128, 0.5)
                          : Theme.of(context).colorScheme.primary,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(222, 221, 251, 0.5),
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
                                '        校园网自动登录',
                                style: TextStyle(
                                    fontSize: UIConfig.fontSizeTitle * 1.2),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            HelpButton(
                                color: const Color.fromRGBO(59, 114, 217, 1)),
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
              Stack(
                children: [
                  Center(
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (BuildContext context, Widget? child) {
                        return Container(
                          width: MediaQuery.of(context).size.width*0.61 * _animation.value,
                          height: MediaQuery.of(context).size.width*0.61 * _animation.value,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(
                                66, 128, 237,  0.4 - (_animation.value / 5)),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(66, 128, 237, 0.15),
                                spreadRadius: 10 * _animation.value,
                                blurRadius: 30 * _animation.value,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: IgnorePointer(
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.422,
                        height: MediaQuery.of(context).size.width*0.422,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(59, 114, 217, 1),
                        ),
                        child: Icon(
                          MyIcons.link,
                          size: MediaQuery.of(context).size.width*0.208,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom:
                    isExpanded ? 0 : -MediaQuery.of(context).size.height / 2,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: MediaQuery.of(context).size.height * 0.29,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: const Login(),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: isExpanded?
        Stack(
          children: [
            Positioned(
              right: MediaQuery.of(context).size.width * 0.43,
              bottom: MediaQuery.of(context).size.height * 0.22,
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_down_rounded
                      : Icons.keyboard_arrow_up_rounded,
                  color: Color.fromRGBO(59, 114, 217, 1),
                  size: 40,
                  shadows: const <Shadow>[Shadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 10.0,)],
                ),
              ),
            ),
          ],
        ):
        FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Icon(
            isExpanded
                ? Icons.keyboard_arrow_down_rounded
                : Icons.keyboard_arrow_up_rounded,
            color: Color.fromRGBO(59, 114, 217, 1),
            size: 40,
            shadows: const <Shadow>[Shadow(color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 10.0)],
          ),
        ),
      ),
    );
  }
}

toHomePage(BuildContext context, int currentPageIndex) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => HomePage(
      currentPageIndex: currentPageIndex,
    ),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class HomePage extends StatefulWidget {
  int currentPageIndex; // 默认显示第一个子组件
  HomePage({Key? key, this.currentPageIndex = 0}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: widget.currentPageIndex,
          children: [
            const LoginPage(),
            SettingPage(),
            UrlPage(),
          ],
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.0898,
          child: BottomAppBar(
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(MyIcons.layer,
                      color: widget.currentPageIndex == 2?Color.fromRGBO(44, 44, 44, 1):Color.fromRGBO(111, 111, 111, 1), size: 32),
                  onPressed: () {
                    setState(() {
                      widget.currentPageIndex = 2;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(MyIcons.net,
                      color: widget.currentPageIndex == 0?Color.fromRGBO(44, 44, 44, 1):Color.fromRGBO(111, 111, 111, 1), size: 32),
                  onPressed: () {
                    setState(() {
                      widget.currentPageIndex = 0;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: widget.currentPageIndex == 1?Color.fromRGBO(44, 44, 44, 1):Color.fromRGBO(111, 111, 111, 1),
                    size: 32,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.currentPageIndex = 1;
                    });
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  CumtLoginAccount cumtLoginAccount = CumtLoginAccount();

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

  @override
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
    return Container(
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
            buildTextField("密码", _passwordController, obscureText: true),
          ]),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () => _showLocationMethodPicker(),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(234, 232, 253, 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text("${cumtLoginAccount.cumtLoginMethod?.name}"),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  )),
              ElevatedButton(
                onPressed: () => _handleLogin(context),
                child:
                    Text('登录', style: TextStyle(fontSize: UIConfig.fontSizeMain)),
              ),
              OutlinedButton(
                onPressed: () => _handleLogout(context),
                child:
                    Text('注销', style: TextStyle(fontSize: UIConfig.fontSizeMain)),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

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
          cumtLoginAccount.setCumtLoginMethodByName(picker.getSelectedValues()[0]);
        });
      },
      cancelTextStyle: TextStyle(color: Colors.black),
      confirmTextStyle: TextStyle(color: Colors.black),
    ).showModal(context);
  }

  Widget buildTextField(
      String labelText, TextEditingController textEditingController,
      {obscureText = false, showPopButton = false}) {
    return Stack(
      alignment: obscureText?Alignment.center:Alignment.centerRight,
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.66,
          height: MediaQuery.of(context).size.height*0.04,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(234, 232, 253, 1),
          ),
          child: TextField(
            controller: textEditingController,
            obscureText: obscureText,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide.none,
              ),
              labelText: labelText,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        showPopButton
            ? PopupMenuButton<CumtLoginAccount>(
                icon: const Icon(Icons.arrow_drop_down_outlined),
                onOpened: () {
                  FocusScope.of(context).unfocus();
                },
                onSelected: (account) {
                  setState(() {
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
                              },
                              icon: const Icon(Icons.close))
                        ],
                      ),
                    );
                  }).toList();
                })
            : Container(),
      ],
    );
  }

  void _handleLogout(BuildContext context) {
    CumtLogin.logout(account: cumtLoginAccount).then((value) {
      showSnackBar(context, value);
    });
  }

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
