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
      Prefs.status='0';
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
        if(true){
          var dio = Dio();
          var url = "http://47.115.228.176:8080/schoollink/login";

          try {
            var response = await dio.put(url, data: {
              'school': Prefs.school1,
              'account': Prefs.cumtLoginUsername,
              'method': Prefs.cumtLoginMethod,
            });
            Prefs.first ='1';
          } catch (e) {
            print('PUT request failed: $e');
            if (e is DioError) {
              print('DioError: ${e.response?.data}');
            }
          }

        }
        CumtLoginAccount.addList(account);
        Prefs.status='1';
        return '登录成功！';
      } else {
        switch (map["ret_code"]) {
          case "2":
            {
              CumtLoginAccount.addList(account);
              Prefs.status='1';
              return '您已登录校园网';
            }
          case "1":
            {
              if (map['msg'] ==Prefs.respond[0]['value']) {
                Prefs.status='0';
                return Prefs.respond[0]['name'];
              } else if (map['msg'] ==Prefs.respond[1]['value']) {
                Prefs.status='0';
                return Prefs.respond[1]['name'];
              } else if (map['msg'] ==Prefs.respond[2]['value']) {
                Prefs.status='0';
                return Prefs.respond[2]['name'];
              } else {
                Prefs.status='1';
                return '未知错误，但是不影响使用';
              }
            }
        }
        return "hhhhh";
      }
    } catch (e) {
      Prefs.status='0';
      return "登录失败，确保您已经连接校园网(CUMT_Stu或CUMT_tec)";
    }
  }
}
