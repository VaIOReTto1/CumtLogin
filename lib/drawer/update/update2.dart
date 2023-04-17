import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cumt_login/config.dart';

//  使用说明
//  1.在main函数里使用
//  在main函数的LoginPage里的initState里，添加如下代码：

//  Update.initCheckUpdate();

//  Update.checkNeedUpdate().then((_){
//    if(Update.isUpDate == true && Update.isIgnore!=true ){
//      showDialog(context: context, builder: (BuildContext context){
//         return const UpdateDialog();
//        });
//      }
//    });

//  2.在抽屉栏里使用
//  直接为检查更新的inkWell的onTap里填入
//  showDialog(context: context, builder: (BuildContext context){
//             return const UpdateDialog();
//           });

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
    try{
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      Update.version = packageInfo.version;
    }catch(e){
      print('getVersionERROR:$e');
    }
  }

  // 初始化时使用的检查用户更新
  static Future initCheckUpdate() async {

    // 获取用户平台
    if(Platform.isAndroid){
      Update.platform = 'android';
    }else if(Platform.isIOS){
      Update.platform = 'ios';
    }else if(Platform.isWindows){
      Update.platform = 'windows';
    }

    // 获取用户版本
    try {
      await Update.getVersion();
      Dio dio = Dio();
      Response response = await dio.get('http://47.115.228.176:8080/update/check?version=${Update.version}&platform=${Update.platform}');
      mapData = response.data;
      print(mapData);
      Update.upVersion = mapData!['version'];
      Update.upDateUrl = mapData!['url'];
      Update.uri = Uri.parse(Update.upDateUrl!);
    }catch(e){
      print(e);
    }
  }

  // 判断是否需要更新
  static Future checkNeedUpdate() async{
    await Update.initCheckUpdate();
    Update.isIgnore = await Update.getIsIgnore();
    if(Update.upVersion!=null&&Update.upVersion!=Update.version){
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

// 版本更新 Dialog
class UpdateDialog extends StatelessWidget {

  const UpdateDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('点击文本下载最新版本 :)',
        style: TextStyle(fontSize: UIConfig.fontSizeSubTitle),),
      content: InkWell(
        child:Text('更新以下功能:${Update.upDateDescription}',
          style: TextStyle(fontSize: UIConfig.fontSizeSubMain),),
        onTap: (){
          launchUrl(Update.uri);
          //这里同样为下一次的检查更新做准备，设置存储的是否忽略为false
          Update.saveIsIgnore(false);
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('下次再提醒我'),
        ),
        TextButton(
          onPressed: () {
            Update.saveIsIgnore(true);
            Navigator.of(context).pop();
            // 这里没有使用异步，是为了提高用户使用的流畅性，但是是否flutter存数据存的不够快？导致还没有存上数据用户就退出程序了？
          },
          child: const Text('忽略此版本'),
        ),
      ],
    );
  }
}