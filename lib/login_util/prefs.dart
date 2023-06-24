import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<void> init() async{
    prefs = await SharedPreferences.getInstance();
    _initRespond();
  }

  static SharedPreferences? prefs;
  static const String _cumtLoginUsername = "cumtLoginUsername";
  static const String _cumtLoginPassword = "cumtLoginPassword";
  static const String _cumtLoginAccountList = "cumtLoginAccountList";
  static const String _cumtLoginMethod = "cumtLoginMethod";
  static const String _school = "school";
  static const String _loginurl = "loginurl";
  static const String _logouturl = "logouturl";
  static const String _status = "status";
  static const String _isDark = "theme";
  static const String _first = "first";
  static const String _image = "image";

  static const String _respondKey = "respond";
  static List<Map<String, dynamic>> _respond = [];
  static const String _urlKey = "url";
  static List<Map<String, String>> _url = [];
  static List<Map<String, String>> _schoolselection = [];

  static Future<void> _initRespond() async {
    String json = _get(_respondKey) ?? "";
    if (json.isEmpty) {
      _set(_respondKey, jsonEncode([
        {'value':'value','name':'name','status':'status'}
      ]));
    } else {
      _respond = List<Map<String, dynamic>>.from(jsonDecode(json));
    }

    json = _get(_urlKey) ?? "";
    if (json.isEmpty) {
      _set(_urlKey, jsonEncode([
        {'name':'name','url':'url'}
      ]));
    } else {
      _url = (jsonDecode(json) as List).map((e) => Map<String, String>.from(e)).toList();
    }

    _schoolselection = await readschoolselection();
  }

  static String get cumtLoginUsername => _get(_cumtLoginUsername);
  static String get cumtLoginPassword => _get(_cumtLoginPassword);
  static String get cumtLoginAccountList => _get(_cumtLoginAccountList);
  static String get cumtLoginMethod => _get(_cumtLoginMethod);
  static String get school => _get(_school);
  static String get loginurl => _get(_loginurl);
  static String get logouturl => _get(_logouturl);
  static String get isDark => _get(_isDark);
  static String get status => _get(_status);
  static String get first => _get(_first);
  static String get image => _get(_image);

  static List<Map<String, dynamic>> get respond {
    return _respond;
  }
  static List<Map<String, String>> get url {
    return _url;
  }
  static List<Map<String, String>> get schoolselection {
    return _schoolselection;
  }

  static set cumtLoginUsername(String value) => _set(_cumtLoginUsername, value);
  static set cumtLoginPassword(String value) => _set(_cumtLoginPassword, value);
  static set cumtLoginAccountList(String value) => _set(_cumtLoginAccountList, value);
  static set cumtLoginMethod(String value) => _set(_cumtLoginMethod, value);
  static set school(String value) => _set(_school, value);
  static set loginurl(String value) => _set(_loginurl, value);
  static set logouturl(String value) => _set(_logouturl, value);
  static set isDark(String value) => _set(_isDark, value);
  static set status(String value) => _set(_status, value);
  static set first(String value) => _set(_first, value);
  static set image(String value) => _set(_image, value);

  static set respond(List<Map<String, dynamic>> value) {
    _respond = value;
    _set(_respondKey, jsonEncode(value));
  }
  static set url(List<Map<String, String>> value) {
    _url = value;
    _set(_urlKey, jsonEncode(value));
  }

  static String _get(String key) => prefs?.getString(key)??"";
  static _set(String key, String value) => prefs?.setString(key, value);
}

void saveschoolelection(List<Map<String, String>> schoolelection) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String schoolelectionJson = jsonEncode(schoolelection);
  await prefs.setString("schoolelection", schoolelectionJson);
}

Future<List<Map<String, String>>> readschoolelection() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // 没有数据则初始化为空列表
  String schoolelectionJson = prefs.getString("schoolelection")  ?? "[]";
  final schoolelection = jsonDecode(schoolelectionJson);
  return List<Map<String, String>>.from(schoolelection.map((e) => Map<String, String>.from(e)));
}

void saveschoolselection(List<Map<String, String>> schoolelection) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String schoolelectionJson = jsonEncode(schoolelection);
  await prefs.setString("schoolselection", schoolelectionJson);
}

Future<List<Map<String, String>>> readschoolselection() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // 没有数据则初始化为空列表
  String schoolelectionJson = prefs.getString("schoolselection")  ?? "[]";
  final schoolelection = jsonDecode(schoolelectionJson);
  return List<Map<String, String>>.from(schoolelection.map((e) => Map<String, String>.from(e)));
}
