import 'package:bot_toast/bot_toast.dart';
import 'package:cumt_login/config.dart';
import 'package:cumt_login/drawer/backgroundimage/imageselect.dart';
import 'package:cumt_login/drawer/drawer_page.dart';
import 'package:cumt_login/shortcut/ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'drawer/theme/theme_color.dart';
import 'drawer/update/app_upgrade2.dart';
import 'login_util/account.dart';
import 'login_util/locations.dart';
import 'login_util/login.dart';
import 'login_util/methods.dart';
import 'login_util/prefs.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BotToastInit();
  await Prefs.init();
  runApp((MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ],
    child: const MyApp(),
  )));
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
        );
      },
      child: const LoginPage(),
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

  @override
  void initState() {
    super.initState();
    ThemeProvider;
    WidgetsBinding.instance.addObserver(this);
    _usernameController.text = cumtLoginAccount.username!;
    _passwordController.text = cumtLoginAccount.password!;
    if (_usernameController.text.isNotEmpty) {
      _handleLogin(context);
    }
    // checkUpgrade(context);      //打开app后默认检查更新

    //Update.initCheckUpdate(context,auto: true);

    Update.checkNeedUpdate(context,auto: true).then((_){
      if(Update.isUpDate == true && Update.isIgnore!=true ){
        showDialog(context: context, builder: (BuildContext context){
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
        appBar: AppBar(
          //automaticallyImplyLeading: false, // 禁用默认的返回箭头
          title: Text('校园网自动登录',
              style: TextStyle(fontSize: UIConfig.fontSizeTitle * 1.2)),
        ),
        body: Stack(
          children: [
            const BackGroundImage(),
            Center(
              child: Padding(
                padding: EdgeInsets.all(UIConfig.paddingAll),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height*0.07,),
                            QQButton(),
                            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                            GlassMorphism(child: const Shortcut()),
                            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                            Column(
                              children: [
                                const SizedBox(height: 16.0),
                                GlassMorphism(
                                    child: buildTextField("账号", _usernameController,
                                        showPopButton: true)),
                                const SizedBox(height: 16.0),
                                GlassMorphism(
                                    child: buildTextField("密码", _passwordController,
                                        obscureText: true)),
                                const SizedBox(height: 16.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                        onPressed: () => _showLocationMethodPicker(),
                                        child: Row(
                                          children: [
                                            Text(
                                                "${cumtLoginAccount.cumtLoginLocation?.name} ${cumtLoginAccount.cumtLoginMethod?.name}"),
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        drawer: const DrawerPage(),
      ),
    );
  }

  void _showLocationMethodPicker() {
    Picker(
        adapter: PickerDataAdapter<dynamic>(pickerData: [
          CumtLoginLocationExtension.nameList,
          CumtLoginMethodExtension.nameList,
        ], isArray: true),
        changeToFirst: true,
        hideHeader: false,
        onConfirm: (Picker picker, List value) {
          setState(() {
            cumtLoginAccount
                .setCumtLoginLocationByName(picker.getSelectedValues()[0]);
            cumtLoginAccount
                .setCumtLoginMethodByName(picker.getSelectedValues()[1]);
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
                                " ${account.cumtLoginLocation?.name} ${account.cumtLoginMethod?.name}",
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

class QQButton extends StatefulWidget {
  const QQButton({Key? key}) : super(key: key);

  @override
  State<QQButton> createState() => _QQButtonState();
}

class _QQButtonState extends State<QQButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
      ),
      child: Text('加入QQ群',
          style: TextStyle(
              fontSize: UIConfig.fontSizeMain)),
      onPressed: () {
        launchUrl(Uri.parse('https://jq.qq.com/?_wv=1027&k=RPprjgMn'),
            mode: LaunchMode.externalApplication);
      },
    );
  }
}
