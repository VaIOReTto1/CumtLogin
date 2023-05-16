import 'package:flutter/material.dart';
import 'main.dart';
import 'login_util/SchoolDio.dart';
import 'login_util/prefs.dart';

class WelComePage extends StatefulWidget {
  const WelComePage({Key? key}) : super(key: key);

  @override
  State<WelComePage> createState() => _WelComePageState();
}

class _WelComePageState extends State<WelComePage> {
  bool _showDialog = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('欢迎'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SchoolButton('中国矿业大学南湖校区', 'nanhu'),
            SchoolButton('中国矿业大学文昌校区', 'wenchang'),
          ],
        ),
      ),
    );
  }

  void _showMyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("提示"),
        content: Text("在选择学校前要保证设备处于联网环境"),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showDialog = false;
              });
              Navigator.of(context).pop();
            },
            child: Text("关闭"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (_showDialog) {
        _showMyDialog();
      }
    });
  }

  @override
  Widget SchoolButton(String schoolname, String school) {
    return InkWell(
        onTap: () async {
          Prefs.school = school;
          await SchoolDio.SchoolUrlDio(Prefs.school);
          toLoginPage(context);
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

