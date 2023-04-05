import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';

import 'login_util/account.dart';
import 'login_util/locations.dart';
import 'login_util/login.dart';
import 'login_util/methods.dart';
import 'login_util/prefs.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
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
    WidgetsBinding.instance.addObserver(this);
    _usernameController.text = cumtLoginAccount.username!;
    _passwordController.text = cumtLoginAccount.password!;
    _handleLogin(context);
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
    /// 停用并移植到新版本
    if (DateTime.now().isAfter(DateTime(2023, 3, 25))) {
      return const Scaffold(
        body: Center(
          child: Text(
            "该测试版已过期\n请加QQ群：839372371或957634136获取最新版本",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('矿小助CUMT校园网登录 1.3'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "新功能：\n"
                      "1.添加了文昌校区接口\n"
                      "2.多账号功能\n（账号栏右边的小按钮，当成功登录后自动保存）\n"
                      "自动登录时机：初始化App或从后台调出",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16.0),
                buildTextField("账号", _usernameController, showPopButton: true),
                const SizedBox(height: 16.0),
                buildTextField("密码", _passwordController, obscureText: true),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () => _showLocationMethodPicker(),
                        child: Row(
                          children: [
                            Text("${cumtLoginAccount.cumtLoginLocation?.name} ${cumtLoginAccount.cumtLoginMethod?.name}"),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        )),
                    ElevatedButton(
                      onPressed: () => _handleLogin(context),
                      child: const Text('登录'),
                    ),
                    OutlinedButton(
                      onPressed: () => _handleLogout(context),
                      child: const Text('注销'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "本App用于测试矿小助新功能\n"
                  "3月25日之后将停用\n"
                  "如果遇到问题请加QQ群反馈\n"
                  "1群：839372371，2群：957634136",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
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
          CumtLoginLocationExtension.nameList,
          CumtLoginMethodExtension.nameList,
        ], isArray: true),
        changeToFirst: true,
        hideHeader: false,
        onConfirm: (Picker picker, List value) {
          setState(() {
            cumtLoginAccount.setCumtLoginLocationByName(picker.getSelectedValues()[0]);
            cumtLoginAccount.setCumtLoginMethodByName(picker.getSelectedValues()[1]);
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
              labelText: labelText,
              border: const OutlineInputBorder(),
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
              itemBuilder: (context)  {
                return CumtLoginAccount.list.map((account) {
                  return PopupMenuItem<CumtLoginAccount>(
                    value: account,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text("${account.username}"
                            " ${account.cumtLoginLocation?.name} ${account.cumtLoginMethod?.name}",),),
                        IconButton(onPressed: (){
                          CumtLoginAccount.removeList(account);
                          _showSnackBar(context, "删除成功");
                          Navigator.of(context).pop();
                        }, icon: const Icon(Icons.close))

                      ],
                    ),
                  );
                }).toList();
              }
          )
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
        content: Text(text),
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
