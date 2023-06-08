import 'dart:convert';
import 'prefs.dart';
import 'package:dio/dio.dart';

//获取学校信息
class SchoolDio{
  static Future<void> SchoolUrlDio(int index) async {
    Dio dio = Dio();
    Response res1 = await dio.get("http://47.115.228.176:8083/schoollink");
    Map<String, dynamic> mapData = jsonDecode(res1.toString());
    final school = mapData['school'][index];
    Prefs.loginurl=school['login']['url'];
    Prefs.logouturl=school['logout']['url'];
    Prefs.school=school['name'];

    Prefs.respond.clear();
    for (var response in school['login']['response']) {
      Prefs.respond.add({
        'value': response['value'],
        'name': response['name'],
        'status': response['status']
      });
    }

    Prefs.url.clear();
    for (var url in school['url']) {
      Prefs.url.add({
        'name':url['name'],
        'url':url['url'],
      });
    }
    print(Prefs.url);
  }
}
