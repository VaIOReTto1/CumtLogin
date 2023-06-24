import 'dart:convert';
import 'package:cumt_login/config.dart';
import 'package:cumt_login/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../login_util/SchoolDio.dart';
import '../login_util/prefs.dart';

toWelcomePage(BuildContext context) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => const WelcomePage(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool flag = false;
  bool _showDialog = true;
  String searchString = "";
  List<Map<String, String>>schoolelection=[{'school':'','index':''}];

  Future<void> searchStringChange(String v) async {
    Dio dio = Dio();
    Response res1 = await dio.get("http://47.115.228.176:8083/schoollink");
    Map<String, dynamic> mapData = jsonDecode(res1.toString());
    setState(() {
      searchString = v;
      if(searchString != "") {
        //重置搜索结果
        schoolelection.clear();
        schoolelection=[{'school':'','index':''}];
        flag = true;
        //输入搜索结果
        for (int i = 0; i < mapData['school'].length; i++) {
          final school = mapData['school'][i]['name'];
          if (school.contains(searchString) && !schoolelection.any((element) => element['school']?.contains(school) ?? false)) {
            schoolelection.add({'school':school,'index':i.toString()});
          }
        }
      }else{
        flag = false;
      }
    });
  }

  //提示联网弹窗
  void _showMyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("提示"),
        content: const Text("在选择学校前要保证设备处于联网环境"),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showDialog = false;
              });
              Navigator.of(context).pop();
            },
            child: const Text("关闭"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () {
      if (_showDialog) {
        _showMyDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Material(
      child: ColoredBox(
        color:const Color.fromRGBO(56, 111, 211, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 345,child: Column(
              children: [
                Expanded(flex:190,child: Container()),
                Expanded(flex:80,child:
                Row(children:[
                  Expanded(flex: 40,child: Container()),
                  Expanded(flex:200,child: Text('Welcome\nBack',style: TextStyle(color: Colors.white,fontSize: UIConfig.welcomeTitle ,fontWeight: FontWeight.w400),)),
                  Expanded(flex: 180,child: Container()),
                ]
                )
                ),
                Expanded(flex:25,child: Container()),
                Expanded(flex:20,child:
                Row(children:[
                  Expanded(flex: 36,child: Container()),
                  Expanded(flex: 41,child: Text('学校',style:TextStyle(color: Colors.white,fontSize: UIConfig.welcomeSubtitle,fontWeight:FontWeight.w600 ))),
                  Expanded(flex: 283,child: Container()),])
                ),
                Expanded(flex:25,child: Container()),
              ],
            ),),
            Expanded(
              flex: 40,
              child: Row(
                children: [
                  Expanded(flex: 1,child: Container()),
                  Expanded(
                    flex: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10.0),
                          topRight: const Radius.circular(10.0),
                          bottomLeft: flag? Radius.zero:const Radius.circular(10.0),
                          bottomRight: flag? Radius.zero:const Radius.circular(10.0),
                        ),
                        color: Colors.white,
                      ),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          // 每输入一个字就会调用该函数
                         searchStringChange(value);
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 7.0),
                          hintText: "请输入学校",
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search),
                        ),

                      ),
                    ),
                  ),
                  Expanded(flex: 1,child: Container())
                ],
              ),
            ),
            Expanded(flex: 395,child:
            Column(
              children: [
                Expanded(
                  flex: 150,
                  child: Row(
                    children: [
                      Expanded(flex:1,child: Container()),
                      Expanded(flex:8,child: flag? SearchResult() : Container()),
                      Expanded(flex:1,child: Container()),
                    ],
                  ),
                ),
                Expanded(flex: 245, child: Container())
              ],
            )
            )
          ],
        ),
      ),
    );
  }

  //展示搜索界面
  Widget SearchResult(){
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            topLeft: Radius.zero,
            topRight: Radius.zero,
          ),
          color: Colors.white,
        ),
        child: ListView.builder(
          itemCount: schoolelection.length==1?1:schoolelection.length-1,
          itemBuilder: (BuildContext context, int index) {
            return schoolelection.length!=1?ListTile(
              onTap: () async {
                int myInt = int.parse(schoolelection[index+1]['index']!);
                await SchoolDio.SchoolUrlDio(myInt);
                toHomePage(context, 0);
              },
              title: Text(schoolelection[index+1]['school']!,style: TextStyle(color: Colors.black),),
              subtitle: const Divider(
                color: Colors.black12,
                thickness: 1,
              ),
            ):const ListTile(
              title: Text('没有搜索到该学校，请检查输入学校是否正确\n如果无你所在学校，请添加QQ群：738340698\n与我们进行合作',style: TextStyle(color: Colors.black),),
              subtitle: Divider(
                color: Colors.black12,
                thickness: 1,
              ),
            );
          },
        )
    );
  }
}



