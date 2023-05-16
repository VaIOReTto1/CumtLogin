import 'dart:convert';
import 'prefs.dart';
import 'package:dio/dio.dart';

class SchoolDio{
  static Future<void> SchoolUrlDio(String school) async {
    Dio dio = Dio();
    print("http://47.115.228.176:8083/$school");
    Response res1 = await dio.get("http://47.115.228.176:8083/$school");
    Map<String, dynamic> mapData = jsonDecode(res1.toString());

    Prefs.loginurl=mapData['login']['url'];
    Prefs.logouturl=mapData['logout']['url'];

    Prefs.respond.clear();
    for (var response in mapData['login']['response']) {
      Prefs.respond.add({
        'value': response['value'],
        'name': response['name'],
        'status': response['status']
      });
    }
  }
}
