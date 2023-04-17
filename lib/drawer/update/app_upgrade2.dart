import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cumt_login/config.dart';

import 'bottom_Dialogue.dart';

class Update {
  // 用户的版本号和设备
  static String? version;
  static String? platform;

  // 从后端获取的数据: 新版本号 下载地址 更新描述
  static String? upVersion;
  static String? upDateUrl;
  static late Uri uri; // Dialog的超链接要使用
  static String? upDateDescription;

  //用户选择 忽略此版本
  static bool? isIgnore;

  // 是否弹出对话框
  static bool? isUpDate;

  // 设置mapData临时存储后端数据
  static Map? mapData;

  // 得到用户当前版本号
  static Future getVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      Update.version = packageInfo.version;
    } catch (e) {
      print('getVersionERROR:$e');
    }
  }

  // 初始化时使用的检查用户更新
  static Future initCheckUpdate(BuildContext context) async {

    Update.platform = Platform.operatingSystem;

    // 获取用户版本
    try {
      await Update.getVersion();
      Dio dio = Dio();
      Response res = await dio.get("http://47.115.228.176:8080/update/check",
          queryParameters: {
            'version': Update.version.toString(),
            'platform': Update.platform
          });
      //mapData = res.data;
      Map<String, dynamic> mapData = jsonDecode(res.toString());
      print(mapData);
      Update.upVersion = mapData['version'];
      Update.upDateUrl = mapData['url'];
      Update.upDateDescription = mapData['description'];
      Update.uri = Uri.parse(Update.upDateUrl!);
    } catch (e) {
      show(context, "获取最新版本失败(X_X)");
    }
  }

  // 判断是否需要更新
  static Future checkNeedUpdate(BuildContext context) async {
    await Update.initCheckUpdate(context);
    Update.isIgnore = await Update.getIsIgnore();
    if (Update.upVersion != null && Update.upVersion != Update.version) {
      Update.isUpDate = true;
    }
  }

  // 得到用户的是否忽略选择
  static Future<bool?> getIsIgnore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isIgnore');
  }

  // 存储用户的是否忽略选择
  static Future<void> saveIsIgnore(bool isIgnore) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isIgnore', isIgnore);
  }
}

class UpgradeDialog extends StatefulWidget {
  @override
  _UpgradeDialogState createState() => _UpgradeDialogState();
}

class _UpgradeDialogState extends State<UpgradeDialog> {
  @override
  void initState() {
    super.initState();
    print("成功链接");
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      // 剧中组件
      child: new Material(
        borderRadius: BorderRadius.circular(UIConfig.borderRadiusEntry),
        child: new Container(
          width: MediaQuery.of(context).size.width * 0.8, // 宽度是整宽的百分之80
          padding: EdgeInsets.fromLTRB(
              0, UIConfig.paddingVertical * 2, 0, UIConfig.paddingVertical * 2),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary == Colors.blue
                ? Colors.grey.shade300
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(
                Radius.circular(UIConfig.borderRadiusEntry)), // 圆角
          ),
          child: Wrap(
            runSpacing: 10,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                width: double.infinity,
                alignment: Alignment.center,
                child: Text("发现最新版本！",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: UIConfig.fontSizeSubTitle)),
              ),
              Container(
                height: 400,
                width: double.infinity,
                child: new SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 15.0),
                      child: new Text('$Update.upDateDescription',
                          style: new TextStyle(
                              color: Theme.of(context).colorScheme.primary ==
                                      Colors.blue
                                  ? Color(0xff7A7A7A)
                                  : Colors.white,
                              fontSize: UIConfig.fontSizeSubMain))),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: Center(
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text("暂不更新",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                                  .colorScheme
                                                  .primary ==
                                              Colors.blue
                                          ? Colors.black38
                                          : Colors.white,
                                      fontSize: UIConfig.fontSizeSubMain)))),
                      onTap: () async {
                        Update.saveIsIgnore(true);
                        setState(() {
                          Update.isIgnore=true;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                        child: Center(
                            child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text("立即更新",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff00c5a8),
                                  fontSize: UIConfig.fontSizeSubMain)),
                        )),
                        onTap: () async {
                          Update.saveIsIgnore(false);
                          launchUrl(Update.uri);
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    //if (!token.isCancelled) token?.cancel();
    super.dispose();
    debugPrint("升级销毁");
  }
}

class UpgradeDialog2 extends StatefulWidget {
  @override
  _UpgradeDialog2State createState() => _UpgradeDialog2State();
}

class _UpgradeDialog2State extends State<UpgradeDialog2> {
  @override
  void initState() {
    super.initState();
    print("成功链接");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // 剧中组件
      child: Material(
        borderRadius: BorderRadius.circular(UIConfig.borderRadiusEntry),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // 宽度是整宽的百分之80
          padding: EdgeInsets.fromLTRB(
              0, UIConfig.paddingVertical * 2, 0, UIConfig.paddingVertical * 2),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary == Colors.blue
                ? Colors.grey.shade300
                : Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(
                Radius.circular(UIConfig.borderRadiusEntry)), // 圆角
          ),
          child: Wrap(
            runSpacing: 10,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                width: double.infinity,
                alignment: Alignment.center,
                child: Text("发现最新版本！",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: UIConfig.fontSizeSubTitle)),
              ),
              Container(
                height: 400,
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 15.0),
                      child: Text('$Update.upDateDescription',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary ==
                                  Colors.blue
                                  ? const Color(0xff7A7A7A)
                                  : Colors.white,
                              fontSize: UIConfig.fontSizeSubMain))),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: Center(
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text("暂不更新",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary ==
                                          Colors.blue
                                          ? Colors.black38
                                          : Colors.white,
                                      fontSize: UIConfig.fontSizeSubMain)))),
                      onTap: () async {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                        child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text("立即更新",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff00c5a8),
                                      fontSize: UIConfig.fontSizeSubMain)),
                            )),
                        onTap: () async {
                          launchUrl(Update.uri);
                          Update.saveIsIgnore(false);
                          setState(() {
                            Update.isIgnore=false;
                          });
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    //if (!token.isCancelled) token?.cancel();
    super.dispose();
    debugPrint("升级销毁");
  }
}
