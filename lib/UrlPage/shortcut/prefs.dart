import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void saveLinks(List<Map<String, String>> links) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String linksJson = jsonEncode(links);
  await prefs.setString("links", linksJson);
}

Future<List<Map<String, String>>> readLinks() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // 没有数据则初始化为空列表
  String linksJson = prefs.getString("links")  ?? "[]";
  final links = jsonDecode(linksJson);
  return List<Map<String, String>>.from(links.map((e) => Map<String, String>.from(e)));
}

