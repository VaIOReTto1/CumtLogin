import 'dart:convert';
import 'package:cumt_login/config/config.dart';
import 'package:cumt_login/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Login/login_util/SchoolDio.dart';

toWelcomePage(BuildContext context) {
  Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) {
    return const WelcomePage();
  }));
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool flag = false;
  bool _showDialog = true;
  String searchString = "";
  List<Map<String, String>> schoolelection = [
    {'school': '', 'index': ''}
  ];

  final List<Map<String, dynamic>> _localSchools = [];

  Future<void> _loadLocalConfig() async {
    try {
      final jsonString =
          await rootBundle.loadString('config/config.json');
      final config = jsonDecode(jsonString) as Map<String, dynamic>;
      _localSchools
          .addAll((config['school'] as List).cast<Map<String, dynamic>>());
    } catch (e) {
      debugPrint('本地配置加载失败: $e');
    }
  }

  Future<void> searchStringChange(String query) async {
    try {
      List<dynamic> schools = [];

      // 尝试获取网络数据
      // final dio = Dio();
      // final response = await dio.get(
      //   "http://1.117.72.161:8083/schoollink",
      //   options: Options(receiveTimeout: const Duration(seconds: 1)),
      // );
      //
      // if (response.statusCode == 200) {
      //   schools = (jsonDecode(response.data))['school'] as List;
      // } else {
      //   schools = _localSchools; // 使用本地配置
      // }
      schools = _localSchools;

      // 处理搜索结果
      final results = schools
          .asMap()
          .entries
          .where((entry) =>
              (entry.value['name'] as String?)?.contains(query) ?? false)
          .map((entry) => {
                'school': entry.value['name'].toString(),
                'index': entry.key.toString(),
              })
          .toList();

      setState(() {
        schoolelection = results;
        flag = query.isNotEmpty;
        print(schoolelection);
      });
    } catch (e) {
      debugPrint('搜索失败: $e');
      // 降级到本地配置
      final results = _localSchools
          .asMap()
          .entries
          .where((entry) =>
              (entry.value['name'] as String?)?.contains(query) ?? false)
          .map((entry) => {
                'school': entry.value['name'].toString(),
                'index': entry.key.toString(),
              })
          .toList();

      setState(() {
        schoolelection = results;
        flag = query.isNotEmpty;
      });
    }
  }

  //提示联网弹窗
  void _showMyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("提示"),
        content: const Text("在选择学校前要保证设备处于联网环境"),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showDialog = false;
              });
              Navigator.of(context).pop();
            },
            child: const Text("关闭"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadLocalConfig();

    Future.delayed(Duration.zero, () {
      if (_showDialog) {
        _showMyDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ColoredBox(
        color: const Color.fromRGBO(56, 111, 211, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 345,
              child: Column(
                children: [
                  Expanded(flex: 190, child: Container()),
                  Expanded(
                      flex: 80,
                      child: Row(children: [
                        Expanded(flex: 40, child: Container()),
                        Expanded(
                            flex: 200,
                            child: Text(
                              'Welcome\nBack',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: UIConfig.welcomeTitle,
                                  fontWeight: FontWeight.w400),
                            )),
                        Expanded(flex: 180, child: Container()),
                      ])),
                  Expanded(flex: 25, child: Container()),
                  Expanded(
                      flex: 20,
                      child: Row(children: [
                        Expanded(flex: 36, child: Container()),
                        Expanded(
                            flex: 41,
                            child: Text('学校',
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: UIConfig.welcomeSubtitle,
                                    fontWeight: FontWeight.w600))),
                        Expanded(flex: 283, child: Container()),
                      ])),
                  Expanded(flex: 25, child: Container()),
                ],
              ),
            ),
            Expanded(
              flex: 40,
              child: Row(
                children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10.0),
                          topRight: const Radius.circular(10.0),
                          bottomLeft:
                              flag ? Radius.zero : const Radius.circular(10.0),
                          bottomRight:
                              flag ? Radius.zero : const Radius.circular(10.0),
                        ),
                        color: Colors.white,
                      ),
                      child: TextField(
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (value) {
                          // 每输入一个字就会调用该函数
                          searchStringChange(value);
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 7.0),
                          hintText: "请输入学校",
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: Container())
                ],
              ),
            ),
            Expanded(
                flex: 395,
                child: Column(
                  children: [
                    Expanded(
                      flex: 150,
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: Container()),
                          Expanded(
                              flex: 8,
                              child: flag ? SearchResult() : Container()),
                          Expanded(flex: 1, child: Container()),
                        ],
                      ),
                    ),
                    Expanded(flex: 245, child: Container())
                  ],
                ))
          ],
        ),
      ),
    );
  }

  //展示搜索界面
  Widget SearchResult() {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            topLeft: Radius.zero,
            topRight: Radius.zero,
          ),
          color: Colors.white,
        ),
        child: ListView.builder(
          itemCount: schoolelection.length == 1 ? 1 : schoolelection.length,
          itemBuilder: (BuildContext context, int index) {
            return schoolelection.length != 1
                ? ListTile(
                    onTap: () async {
                      int myInt =
                          int.parse(schoolelection[index]['index']!);
                      await SchoolDio.schoolUrlDio(myInt);
                      toHomePage(context, 0);
                    },
                    title: Text(
                      schoolelection[index]['school']!,
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: const Divider(
                      color: Colors.black12,
                      thickness: 1,
                    ),
                  )
                : const ListTile(
                    title: Text(
                      '没有搜索到该学校，请检查输入学校是否正确\n如果无你所在学校，请添加QQ群：738340698\n与我们进行合作',
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Divider(
                      color: Colors.black12,
                      thickness: 1,
                    ),
                  );
          },
        ));
  }
}
