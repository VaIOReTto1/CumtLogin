import 'dart:convert';
import 'prefs.dart';
import 'methods.dart';

class CumtLoginAccount{
  late String? _username;
  late String? _password;
  late CumtLoginMethod? _cumtLoginMethod;
  static List<CumtLoginAccount>? _list; /// 账号列表

  CumtLoginAccount(){
    _username = "";
    _password = "";
    _cumtLoginMethod = null;
  }

  CumtLoginAccount.fill(this._username, this._password, this._cumtLoginMethod);

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
    return CumtLoginAccount.fill(_username, _password, _cumtLoginMethod);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    map['method'] = cumtLoginMethod!.name;
    return map;
  }

  CumtLoginAccount.fromJson(dynamic json) {
    username = json['username'];
    password = json['password'];
    cumtLoginMethod = CumtLoginMethodExtension.fromName(json['method']);
  }

  @override
  String toString() {
    return "$username $password  ${cumtLoginMethod!.name}";
  }

  Future<String> loginUrl(
      String? username, String? password, CumtLoginMethod? loginMethod) async {
    String head =Prefs.loginurl;
    head = head.replaceAll('{username}', username ?? '');
    head = head.replaceAll('{methods}', loginMethod!.code ?? '');
    head = head.replaceAll('{password}', password ?? '');
    return head;
  }

  Future<String> get logoutUrl async {
    String head =Prefs.logouturl;
    return head;
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
  CumtLoginMethod? get cumtLoginMethod{
    if(_cumtLoginMethod==null){
      if(Prefs.cumtLoginMethod!=""){
        _cumtLoginMethod = CumtLoginMethodExtension.fromName(Prefs.cumtLoginMethod);
      }else{
        _cumtLoginMethod = CumtLoginMethod.school;
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
        other.cumtLoginMethod == cumtLoginMethod;
  }

  @override
  int get hashCode{
    return username.hashCode^password.hashCode^cumtLoginMethod.hashCode;
  }

}
