import 'dart:convert';
import 'package:cumt_login/login_util/prefs.dart';

import 'locations.dart';
import 'methods.dart';

class CumtLoginAccount{
  late String? _username;
  late String? _password;
  late CumtLoginLocation? _cumtLoginLocation;
  late CumtLoginMethod? _cumtLoginMethod;
  static List<CumtLoginAccount>? _list; /// 账号列表

  CumtLoginAccount(){
    _username = "";
    _password = "";
    _cumtLoginLocation = null;
    _cumtLoginMethod = null;
  }

  CumtLoginAccount.fill(this._username, this._password, this._cumtLoginLocation, this._cumtLoginMethod);

  /// 懒加载账号列表
  static List<CumtLoginAccount> get list{
    if(_list==null){
      _list = [];
      if(Prefs.cumtLoginAccountList!=""){
        jsonDecode(Prefs.cumtLoginAccountList).forEach((v) {
          _list!.add(CumtLoginAccount.fromJson(v));
        });
      }
    }
    return _list!;
  }

  /// 保存账号到历史列表中
  static addList(CumtLoginAccount valueOld){
    CumtLoginAccount value = valueOld.clone();
    // 检查重复项
    int i = 0;
    for(;i<list.length;i++){
      if(list[i]==value) return;
    }
    if(i==list.length){
      list.add(value);
    }
    Prefs.cumtLoginAccountList = jsonEncode(list);
  }

  static removeList(CumtLoginAccount valueOld){
    CumtLoginAccount value = valueOld.clone();
    if(list.remove(value)){
      Prefs.cumtLoginAccountList = jsonEncode(list);
    }
  }

  /// 值拷贝
  CumtLoginAccount clone(){
    return CumtLoginAccount.fill(_username, _password, _cumtLoginLocation, _cumtLoginMethod);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    map['location'] = cumtLoginLocation!.name;
    map['method'] = cumtLoginMethod!.name;
    return map;
  }

  CumtLoginAccount.fromJson(dynamic json) {
    username = json['username'];
    password = json['password'];
    cumtLoginLocation = CumtLoginLocationExtension.fromName(json['location']);
    cumtLoginMethod = CumtLoginMethodExtension.fromName(json['method']);
  }

  @override
  String toString() {
    return "$username $password ${cumtLoginLocation!.name} ${cumtLoginMethod!.name}";
  }

  /// get方法
  String? get username{
    if(_username==""&&Prefs.cumtLoginUsername!=""){
      _username = Prefs.cumtLoginUsername;
    }
    return _username;
  }
  String? get password{
    if(_password==""&&Prefs.cumtLoginPassword!=""){
      _password = Prefs.cumtLoginPassword;
    }
    return _password;
  }
  CumtLoginLocation? get cumtLoginLocation{
    if(_cumtLoginLocation==null){
      if(Prefs.cumtLoginLocation!=""){
        _cumtLoginLocation = CumtLoginLocationExtension.fromName(Prefs.cumtLoginLocation);
      }else{
        _cumtLoginLocation = CumtLoginLocation.nh;
      }
    }
    return _cumtLoginLocation;
  }
  CumtLoginMethod? get cumtLoginMethod{
    if(_cumtLoginMethod==null){
      if(Prefs.cumtLoginMethod!=""){
        _cumtLoginMethod = CumtLoginMethodExtension.fromName(Prefs.cumtLoginMethod);
      }else{
        _cumtLoginMethod = CumtLoginMethod.cumt;
      }
    }
    return _cumtLoginMethod;
  }

  /// set方法
  set username(String? value){
    _username = value;
    Prefs.cumtLoginUsername = value!;
  }
  set password(String? value){
    _password = value;
    Prefs.cumtLoginPassword = value!;
  }
  set cumtLoginLocation(CumtLoginLocation? value){
    _cumtLoginLocation = value;
    Prefs.cumtLoginLocation = value!.name;
  }
  setCumtLoginLocationByName(String? name){
    _cumtLoginLocation = CumtLoginLocationExtension.fromName(name!);
    Prefs.cumtLoginLocation = name;
  }
  set cumtLoginMethod(CumtLoginMethod? value){
    _cumtLoginMethod = value;
    Prefs.cumtLoginMethod = value!.name;
  }
  setCumtLoginMethodByName(String? name){
    _cumtLoginMethod = CumtLoginMethodExtension.fromName(name!);
    Prefs.cumtLoginMethod = name;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CumtLoginAccount &&
        other.username == username &&
        other.password == password &&
        other.cumtLoginLocation == cumtLoginLocation &&
        other.cumtLoginMethod == cumtLoginMethod;
  }

  @override
  int get hashCode{
    return username.hashCode^password.hashCode^cumtLoginLocation.hashCode^cumtLoginMethod.hashCode;
  }

}
