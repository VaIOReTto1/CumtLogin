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

  static const String _respondKey = "respond";
  static const String _theme = "theme";
  static List<Map<String, dynamic>> _respond = [];
  static const String _urlKey = "url";

  static List<Map<String, String>> _url = [];

  static void _initRespond() {
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
  }

  static String get cumtLoginUsername => _get(_cumtLoginUsername);
  static String get cumtLoginPassword => _get(_cumtLoginPassword);
  static String get cumtLoginAccountList => _get(_cumtLoginAccountList);
  static String get cumtLoginMethod => _get(_cumtLoginMethod);
  static String get school => _get(_school);
  static String get loginurl => _get(_loginurl);
  static String get logouturl => _get(_logouturl);
  static String get theme => _get(_theme);
  static String get status => _get(_theme);

  static List<Map<String, dynamic>> get respond {
    return _respond;
  }

  static List<Map<String, String>> get url {
    return _url;
  }

  static set cumtLoginUsername(String value) => _set(_cumtLoginUsername, value);
  static set cumtLoginPassword(String value) => _set(_cumtLoginPassword, value);
  static set cumtLoginAccountList(String value) => _set(_cumtLoginAccountList, value);
  static set cumtLoginMethod(String value) => _set(_cumtLoginMethod, value);
  static set school(String value) => _set(_school, value);
  static set loginurl(String value) => _set(_loginurl, value);
  static set logouturl(String value) => _set(_logouturl, value);
  static set theme(String value) => _set(_theme, value);
  static set status(String value) => _set(_status, value);

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
