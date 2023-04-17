import 'dart:convert';
//import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cumt_login/config.dart';


void checkUpgrade(BuildContext context, {bool auto = true}) async {
  // if(UniversalPlatform.isIOS){
  //   return;
  // }
  PackageInfo cur = await PackageInfo.fromPlatform();

  Response res;
  Dio dio = Dio();
  try {
    res = await dio.get(
        //"https://user.kxz.atcumt.com/admin/version_new",
        "http://10.0.2.2:5000/update/check",
        queryParameters: {'version': cur.version.toString()});
    debugPrint(res.toString());
    Map<String, dynamic> map = jsonDecode(res.toString());
    //这边会随后端更新而继续更新
    // if(map['status']==200){
    //   if(map['check']==true){
    //     updateAlert(context,{
    //       'isForceUpdate': false,//是否强制更新
    //       'content': map['description'],//版本描述
    //       'url': map['apkUrl'],// 安装包的链接
    //     });
    //   }else{
    //     if(auto==false) show(context,"当前为最新版本！");
    //   }
    //   if(map['check']==true){
    updateAlert(context, {
      'isForceUpdate': false, //是否强制更新
      'content': map['description'], //版本描述
      'url': map['apkUrl'], // 安装包的链接
    });
    // }else{
    //   if(auto==false) show( context,"获取最新版本失败(X_X)");
    // }
  } catch (e) {
    //if (auto == false) show(context, "获取最新版本失败(X_X)");
    debugPrint(e.toString());
  }
}

Future<void> updateAlert(BuildContext context, Map data) async {
  bool isForceUpdate = data['isForceUpdate']; // 从数据拿到是否强制更新字段
  showDialog(
    // 显示对话框
    context: context,
    builder: (_) =>
        new UpgradeDialog(data, isForceUpdate, updateUrl: data['url']),
  );
}

class UpgradeDialog extends StatefulWidget {
  final Map data; // 数据
  final bool isForceUpdate; // 是否强制更新
  final String updateUrl; // 更新的url（安装包下载地址）

  UpgradeDialog(this.data, this.isForceUpdate, {required this.updateUrl});

  @override
  _UpgradeDialogState createState() => _UpgradeDialogState();
}

class _UpgradeDialogState extends State<UpgradeDialog> {
  int _downloadProgress = 0; // 进度初始化为0

  //CancelToken token;
  UploadingFlag uploadingFlag = UploadingFlag.idle;

  @override
  void initState() {
    super.initState();
    print("成功链接");
    //token = new CancelToken(); // token初始化
  }

  @override
  Widget build(BuildContext context) {
    String info = widget.data['content']; // 更新内容

    return new Center(
      // 剧中组件
      child: new Material(
        borderRadius: BorderRadius.circular(UIConfig.borderRadiusEntry),
        child: new Container(
          width: MediaQuery.of(context).size.width * 0.8, // 宽度是整宽的百分之80
          padding: EdgeInsets.fromLTRB(
              0, UIConfig.paddingVertical * 2, 0, UIConfig.paddingVertical * 2),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary == Colors.blue ? Colors.grey.shade300 : Theme.of(context).cardColor,
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
                      child: new Text('$info',
                          style: new TextStyle(
                              color: Theme.of(context).colorScheme.primary == Colors.blue ?Color(0xff7A7A7A):Colors.white,
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
                              child: Text("取消",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).colorScheme.primary == Colors.blue ?Colors.black38:Colors.white,
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
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text("立即更新",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xff00c5a8),
                                fontSize: UIConfig.fontSizeSubMain)),
                      )),
                      onTap: () => launch(widget.updateUrl),
                    ),
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

enum UploadingFlag { uploading, idle, uploaded, uploadingFailed }
