import 'dart:convert';

import 'package:dio/dio.dart';
import 'prefs.dart';

import 'account.dart';

class CumtLogin {
  static Dio dio = Dio(
    BaseOptions(
        connectTimeout: const Duration(seconds: 1),
        sendTimeout: const Duration(seconds: 1),
        receiveTimeout: const Duration(seconds: 1)),
  );

  /// 注销
  static Future<String> logout({required CumtLoginAccount account}) async {
    try {
      Dio dio = Dio();
      String url = await account.logoutUrl;
      Response res = await dio.get(url);
      Map<String, dynamic> map =
          jsonDecode(res.toString().substring(1, res.toString().length - 1));
      return map["msg"].toString();
    } catch (e) {
      return '网络错误(X_X)';
    }
  }

  /// 登录
  static Future<String> login({required CumtLoginAccount account}) async {
    try {
      String url = await account.loginUrl(
          account.username, account.password, account.cumtLoginMethod);
      Response res = await dio.get(url);
      Map<String, dynamic> map =
          jsonDecode(res.toString().substring(1, res.toString().length - 1));
      if (map['result'] == "1") {
        CumtLoginAccount.addList(account);
        return '登录成功！';
      } else {
        switch (map["ret_code"]) {
          case "2":
            {
              CumtLoginAccount.addList(account);
              return '您已登录校园网';
            }
          case "1":
            {
              if (map['msg'] ==Prefs.respond[0]['value']) {
                return Prefs.respond[0]['name'];
              } else if (map['msg'] ==Prefs.respond[1]['value']) {
                return Prefs.respond[1]['name'];
              } else if (map['msg'] ==Prefs.respond[2]['value']) {
                return Prefs.respond[2]['name'];
              } else {
                return '未知错误，但是不影响使用';
              }
            }
        }
        return "hhhhh";
      }
    } catch (e) {
      return "登录失败，确保您已经连接校园网(CUMT_Stu或CUMT_tec)";
    }
  }
}
