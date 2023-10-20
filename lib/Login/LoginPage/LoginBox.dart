import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';

import '../../config/config.dart';
import '../../config/theme_color.dart';
import '../../config/toast.dart';
import '../../welcomeback.dart';
import '../login_util/SchoolDio.dart';
import '../login_util/account.dart';
import '../login_util/login.dart';
import '../login_util/methods.dart';
import '../login_util/prefs.dart';

class LoginBox extends StatefulWidget {
  const LoginBox({Key? key}) : super(key: key);

  @override
  State<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  CumtLoginAccount cumtLoginAccount = CumtLoginAccount();

  bool border = true;
  bool borders = true;
  bool isobscureText = true;
  bool imageselect = false;

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          Text(
                            "${cumtLoginAccount.cumtLoginMethod?.name}",
                            style: const TextStyle(color: Colors.black38),
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _handleLogout(context),
                    child: Text('注销',
                        style: TextStyle(fontSize: UIConfig.fontSizeMain)),
                  ),
                  ElevatedButton(
                    onPressed: () => _handleLogin(context),
                    child: Text('登录',
                        style: TextStyle(fontSize: UIConfig.fontSizeMain)),
                  )
                ],
              )
            ],
          ),
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
        UserEdit(showPopButton, obscureText, textEditingController, labelText),
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
                  minWidth: MediaQuery.of(context).size.width * 0.66 -
                      MediaQuery.of(context).size.height * 0.047 -
                      9,
                  maxWidth: MediaQuery.of(context).size.width * 0.66 -
                      MediaQuery.of(context).size.height * 0.047 -
                      9,
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
                                showToast("删除成功");
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

  Widget UserEdit(showPopButton, obscureText,
      TextEditingController textEditingController, String labelText) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.66,
      height: MediaQuery.of(context).size.height * 0.047,
      decoration: BoxDecoration(
        borderRadius: showPopButton
            ? border
                ? borders
                    ? BorderRadius.circular(10)
                    : const BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )
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
            PopupMenuButton<String>(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              elevation: 0,
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.66 -
                    MediaQuery.of(context).size.height * 0.047 -
                    11,
                maxWidth: MediaQuery.of(context).size.width * 0.66 -
                    MediaQuery.of(context).size.height * 0.047 -
                    11,
              ),
              color: const Color.fromRGBO(216, 227, 247, 1),
              offset: Offset(0, MediaQuery.of(context).size.height * 0.047 - 7),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.047 - 7,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: Prefs.image,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              onOpened: () {
                setState(() {
                  borders = !borders;
                });
                FocusScope.of(context).unfocus();
              },
              onCanceled: () {
                setState(() {
                  !borders ? borders = !borders : null;
                });
              },
              onSelected: (value) async {
                Dio dio = Dio();
                Response res1 =
                    await dio.get("http://1.117.72.161:8083/schoollink");
                Map<String, dynamic> mapData = jsonDecode(res1.toString());
                int i = mapData['school']
                    .indexWhere((school) => school['name'] == value);
                SchoolDio.schoolUrlDio(i);
              },
              itemBuilder: (context) {
                return Prefs.schoolselection.map((schoolselection) {
                  return PopupMenuItem<String>(
                    value: schoolselection['name'],
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.047 -
                                      7,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: schoolselection['image']!,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Text(
                              schoolselection['name']!,
                              style: TextStyle(
                                  color: schoolselection['value'] == '1'
                                      ? const Color.fromRGBO(59, 114, 217, 1)
                                      : Colors.black),
                            )),
                            IconButton(
                                onPressed: () {
                                  Prefs.schoolselection.remove(schoolselection);
                                  saveschoolselection(Prefs.schoolselection);
                                  showToast("删除成功");
                                  Navigator.of(context).pop();
                                  border = !border;
                                },
                                icon: const Icon(Icons.close))
                          ],
                        ),
                        if (schoolselection == Prefs.schoolselection.last)
                          const SizedBox(
                            height: 10,
                          ),
                        if (schoolselection == Prefs.schoolselection.last)
                          InkWell(
                            onTap: () {
                              toWelcomePage(context);
                            },
                            child: const Text('添加学校'),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
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
                labelStyle:
                    const TextStyle(color: Color.fromRGBO(191, 191, 191, 1)),
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
    );
  }

//注销
  void _handleLogout(BuildContext context) {
    CumtLogin.logout(account: cumtLoginAccount).then((value) {
      showToast(value);
    });
  }

  //登录
  void _handleLogin(BuildContext context) {
    if (_usernameController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      showToast('账号或密码不能为空');
      return;
    }
    cumtLoginAccount.username = _usernameController.text.trim();
    cumtLoginAccount.password = _passwordController.text.trim();

    CumtLogin.login(account: cumtLoginAccount).then((value) {
      setState(() {
        showToast(value);
      });
    });
  }
}
