import 'dart:convert';

import 'prefs.dart';
import 'package:dio/dio.dart';

//获取学校信息
class SchoolDio {
  static Future<void> schoolUrlDio(int index) async {
    final i = Prefs.schoolselection.indexWhere((element) => element['name'] == Prefs.school1);
    if (i != -1) Prefs.schoolselection[i]['value'] = '0';

    final schoolData = await fetchSchoolData(index);
    if (schoolData != null) {
      Prefs.loginurl = schoolData['login']['url'];
      Prefs.logouturl = schoolData['logout']['url'];
      Prefs.school1 = schoolData['name'];
      Prefs.image = schoolData['image'];

      if (!Prefs.schoolselection.any((element) => element['name']?.contains(Prefs.school1) ?? false)) {
        Prefs.schoolselection.add({'image': Prefs.image, 'name': Prefs.school1, 'value': '0'});
        saveschoolselection(Prefs.schoolselection);
        if (Prefs.schoolselection[0]['image'] == 'image') Prefs.schoolselection.remove(Prefs.schoolselection[0]);
      }

      final i = Prefs.schoolselection.indexWhere((element) => element['name'] == Prefs.school1);
      if (i != -1) Prefs.schoolselection[i]['value'] = '1';
      print(Prefs.schoolselection[i]['value']);

      Prefs.respond.clear();
      Prefs.url.clear();
      schoolData['login']['response'].forEach((response) {
        Prefs.respond.add({'value': response['value'], 'name': response['name'], 'status': response['status']});
      });

      schoolData['url'].forEach((url) {
        Prefs.url.add({'name': url['name'], 'url': url['url']});
      });
    }
  }

  static Future<Map<String, dynamic>?> fetchSchoolData(int index) async {
    try {
      final dio = Dio();
      final res1 = await dio.get("http://1.117.72.161:8083/schoollink");
      final mapData = jsonDecode(res1.toString());
      return mapData['school'][index];
    } catch (e) {
      print('Error fetching school data: $e');
      return null;
    }
  }
}