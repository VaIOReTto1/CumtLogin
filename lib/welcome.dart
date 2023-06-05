import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'UrlPage/shortcut/prefs.dart';
import 'main.dart';
import 'login_util/SchoolDio.dart';
import 'login_util/prefs.dart';

toWelComePage(BuildContext context) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => const WelComePage(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class WelComePage extends StatefulWidget {
  const WelComePage({Key? key}) : super(key: key);

  @override
  State<WelComePage> createState() => _WelComePageState();
}

class _WelComePageState extends State<WelComePage> {
  bool _showDialog = true;
  List<Map<String, String>>schoolelection=[];

  void firstLoad() async {
    // 读取学校数据
    schoolelection = await readschoolelection();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('欢迎'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SchoolButton('中国矿业大学南湖校区', 'nanhu'),
            SchoolButton('中国矿业大学文昌校区', 'wenchang'),
          ],
        ),
      ),
    );
  }

  //提示联网弹窗
  void _showMyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
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
    super.initState();
    firstLoad();
    Future.delayed(Duration.zero, () {
      if (_showDialog) {
        _showMyDialog();
      }
    });
  }

  //获得学校数据
  Widget SchoolButton(String schoolname, String school) {
    return InkWell(
        onTap: () async {
          Prefs.school = school;
          //添加学校
          if (!schoolelection.any((element) => element['schoolname'] == schoolname)) {
            schoolelection.add({'schoolname':schoolname,'school':school});
            saveschoolelection(schoolelection);
          }
          Dio dio = Dio();
          Response res1 = await dio.get("http://47.115.228.176:8083/schoollink");
          Map<String, dynamic> mapData = jsonDecode(res1.toString());
          print(schoolelection);
          await SchoolDio.SchoolUrlDio(Prefs.school);
          toHomePage(context, 0);
        },
        child: ListTile(
          title: Column(
            children: [
              Text(schoolname, textAlign: TextAlign.center),
              const Divider(
                color: Colors.black12,
                thickness: 1,
              ),
            ],
          ),
        )
    );
  }
}

