import 'package:bot_toast/bot_toast.dart';
import 'package:cumt_login/UrlPage/url_page.dart';
import 'package:cumt_login/config.dart';
import 'package:cumt_login/settings//backgroundimage/imageselect.dart';
import 'package:cumt_login/settings/drawer_button.dart';
import 'package:cumt_login/settings/settings.dart';
import 'package:cumt_login/welcome.dart';

import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'UrlPage/shortcut/ui.dart';
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

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  CumtLoginAccount cumtLoginAccount = CumtLoginAccount();

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

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
    _usernameController.text = cumtLoginAccount.username!;
    _passwordController.text = cumtLoginAccount.password!;
    if (_usernameController.text.isNotEmpty) {
      _handleLogin(context);
    }
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
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(UIConfig.paddingAll),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.12,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          '        校园网自动登录',
                          style:
                              TextStyle(fontSize: UIConfig.fontSizeTitle * 1.2),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      HelpButton(color: const Color.fromRGBO(73,114,175,1),),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 16.0),
                          GlassMorphism(
                              child: Column(children: [
                            const SizedBox(
                              height: 5,
                            ),
                            buildTextField("账号", _usernameController,
                                showPopButton: true),
                          ])),
                          const SizedBox(height: 16.0),
                          GlassMorphism(
                              child: Column(children: [
                            const SizedBox(
                              height: 5,
                            ),
                            buildTextField("密码", _passwordController,
                                obscureText: true),
                          ])),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                  onPressed: () => _showLocationMethodPicker(),
                                  child: Row(
                                    children: [
                                      Text(
                                          "${cumtLoginAccount.cumtLoginMethod?.name}"),
                                      const Icon(Icons.arrow_drop_down),
                                    ],
                                  )),
                              ElevatedButton(
                                onPressed: () => _handleLogin(context),
                                child: Text('登录',
                                    style: TextStyle(
                                        fontSize: UIConfig.fontSizeMain)),
                              ),
                              OutlinedButton(
                                onPressed: () => _handleLogout(context),
                                child: Text('注销',
                                    style: TextStyle(
                                        fontSize: UIConfig.fontSizeMain)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLocationMethodPicker() {
    Picker(
        adapter: PickerDataAdapter<dynamic>(pickerData: [
          CumtLoginMethodExtension.nameList,
        ], isArray: true),
        changeToFirst: true,
        hideHeader: false,
        onConfirm: (Picker picker, List value) {
          setState(() {
            cumtLoginAccount
                .setCumtLoginMethodByName(picker.getSelectedValues()[0]);
          });
        }).showModal(context);
  }

  Widget buildTextField(
      String labelText, TextEditingController textEditingController,
      {obscureText = false, showPopButton = false}) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            controller: textEditingController,
            obscureText: obscureText,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
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
                                  _showSnackBar(context, "删除成功");
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
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    CumtLogin.logout(account: cumtLoginAccount).then((value) {
      _showSnackBar(context, value);
    });
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleLogin(BuildContext context) {
    if (_usernameController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      _showSnackBar(context, '账号或密码不能为空');
      return;
    }
    cumtLoginAccount.username = _usernameController.text.trim();
    cumtLoginAccount.password = _passwordController.text.trim();

    CumtLogin.login(account: cumtLoginAccount).then((value) {
      setState(() {
        _showSnackBar(context, value);
      });
    });
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
          child: BottomAppBar(
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.layers_rounded,
                    color: Color.fromRGBO(111, 111, 111, 1),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.currentPageIndex = 2;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.home,
                      color: Color.fromRGBO(111, 111, 111, 1)),
                  onPressed: () {
                    setState(() {
                      widget.currentPageIndex = 0;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.settings,
                      color: Color.fromRGBO(111, 111, 111, 1)),
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
