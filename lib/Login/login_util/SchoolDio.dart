import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'prefs.dart';

class SchoolDio {
  static Future<Map<String, dynamic>?> fetchSchoolData(int index) async {
    // try {
    //   final dio = Dio();
    //   // 尝试网络请求，设置合理的超时时间
    //   final response = await dio.get(
    //     "http://1.117.72.161:8083/schoollink",
    //     options: Options(
    //       receiveTimeout: const Duration(seconds: 5),
    //       sendTimeout: const Duration(seconds: 5),
    //     ),
    //   );
    //   final mapData = jsonDecode(response.toString());
    //   return _validateSchoolData(mapData, index);
    // } catch (e) {
    //   debugPrint('网络请求失败，尝试本地配置: $e');
    //   print('网络请求失败，尝试本地配置: $e');
    //   return await _loadLocalConfig(index);
    // }
    return await _loadLocalConfig(index);
  }

  static Map<String, dynamic>? _validateSchoolData(Map<String, dynamic> data, int index) {
    try {
      final schools = data['school'] as List;
      if (index >= 0 && index < schools.length) {
        return schools[index] as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      debugPrint('服务器数据格式异常: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> _loadLocalConfig(int index) async {
    try {
      // 加载本地配置文件
      final jsonString = await rootBundle.loadString('config/config.json');
      final localData = jsonDecode(jsonString) as Map<String, dynamic>;

      // 验证本地数据格式
      if (!localData.containsKey('school')) {
        throw const FormatException('本地配置文件格式错误');
      }

      final schools = localData['school'] as List;
      if (index >= 0 && index < schools.length) {
        return schools[index] as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      debugPrint('加载本地配置失败: $e');
      return null;
    }
  }

  static Future<void> schoolUrlDio(int index) async {
    try {
      // 清除旧数据
      _clearPreviousSelection();

      // 获取学校数据（优先网络，失败后本地）
      final schoolData = await fetchSchoolData(index) ?? await _loadLocalConfig(index);

      if (schoolData == null) {
        throw Exception('无法获取学校配置信息');
      }

      // 更新配置信息
      _updateSchoolPreferences(schoolData);

      // 处理响应数据
      _processResponseData(schoolData);

      // 处理URL数据
      _processUrlData(schoolData);

    } catch (e) {
      debugPrint('学校配置初始化失败: $e');
      // 可以在这里添加用户提示
    }
  }

  static void _clearPreviousSelection() {
    final currentIndex = Prefs.schoolselection.indexWhere(
            (element) => element['name'] == Prefs.school1
    );

    if (currentIndex != -1) {
      Prefs.schoolselection[currentIndex]['value'] = '0';
    }
  }

  static void _updateSchoolPreferences(Map<String, dynamic> schoolData) {
    Prefs.loginurl = schoolData['login']['url']?.toString() ?? '';
    Prefs.logouturl = schoolData['logout']['url']?.toString() ?? '';
    Prefs.school1 = schoolData['name']?.toString() ?? '未知学校';
    Prefs.image = schoolData['image']?.toString() ?? 'default_image.png';

    final existing = Prefs.schoolselection.any(
            (element) => element['name'] == Prefs.school1
    );

    if (!existing) {
      Prefs.schoolselection.add({
        'image': Prefs.image,
        'name': Prefs.school1,
        'value': '1'
      });
      _cleanDefaultPlaceholder();
    }
  }

  static void _cleanDefaultPlaceholder() {
    if (Prefs.schoolselection.isNotEmpty &&
        Prefs.schoolselection[0]['image'] == 'image') {
      Prefs.schoolselection.removeAt(0);
    }
  }

  static void _processResponseData(Map<String, dynamic> schoolData) {
    Prefs.respond.clear();
    final responses = schoolData['login']['response'] as List? ?? [];
    for (final response in responses) {
      Prefs.respond.add({
        'value': response['value']?.toString() ?? '',
        'name': response['name']?.toString() ?? '未知状态',
        'status': response['status']?.toString() ?? '0'
      });
    }
  }

  static void _processUrlData(Map<String, dynamic> schoolData) {
    Prefs.url.clear();
    final urls = schoolData['url'] as List? ?? [];
    for (final url in urls) {
      Prefs.url.add({
        'name': url['name']?.toString() ?? '未命名链接',
        'url': url['url']?.toString() ?? '#'
      });
    }
  }
}