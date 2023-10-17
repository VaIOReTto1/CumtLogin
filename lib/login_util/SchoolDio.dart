import 'dart:convert';
import 'prefs.dart';
import 'package:dio/dio.dart';

//获取学校信息
class SchoolDio{
  static Future<void> SchoolUrlDio(int index) async {
    int i = Prefs.schoolselection.indexWhere((element) => element['name'] == Prefs.school1);
    if(i!=-1) Prefs.schoolselection[i]['value']='0';

    Dio dio = Dio();
    Response res1 = await dio.get("http://1.117.72.161:8083/schoollink");
    Map<String, dynamic> mapData = jsonDecode(res1.toString());
    final school = mapData['school'][index];
    Prefs.loginurl=school['login']['url'];
    Prefs.logouturl=school['logout']['url'];
    Prefs.school1=school['name'];
    Prefs.image=school['image'];

    if (!Prefs.schoolselection.any((element) => element['name']?.contains(Prefs.school1) ?? false)) {
      print(Prefs.schoolselection);
      Prefs.schoolselection.add({'image': Prefs.image,'name':Prefs.school1,'value':'0'});
      saveschoolselection(Prefs.schoolselection);
      print(Prefs.schoolselection);
      if(Prefs.schoolselection[0]['image'] =='image') Prefs.schoolselection.remove(Prefs.schoolselection[0]);
    }

    i = Prefs.schoolselection.indexWhere((element) => element['name'] == Prefs.school1);
    if(i!=-1) Prefs.schoolselection[i]['value']='1';

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
  }
}
