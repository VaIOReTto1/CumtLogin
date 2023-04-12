import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

extension SharedPreferencesExtension on SharedPreferences {
  Future<bool> setJson(String key, Map<String, dynamic> value) {
    return setString(key, jsonEncode(value));
  }
}
