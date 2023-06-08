import 'dart:convert';
import 'package:cumt_login/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../login_util/SchoolDio.dart';

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
        flag = true;
        for (int i = 0; i < mapData['school'].length; i++) {
          final school = mapData['school'][i]['name'];
          if (school.contains(searchString)) {
            schoolelection.add({'school':school,'index':i.toString()});
          }
          schoolelection.isEmpty?null:print(schoolelection);
        }
      }else{
        flag = false;
      }
    });
    // others
    print(searchString);
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
                  const Expanded(flex:200,child: Text('Welcome\nBack',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.w400),)),
                  Expanded(flex: 180,child: Container()),
                ]
                )
                ),
                Expanded(flex:25,child: Container()),
                Expanded(flex:20,child:
                Row(children:[
                  Expanded(flex: 36,child: Container()),
                  const Expanded(flex: 41,child: Text('学校',style:TextStyle(color: Colors.white,fontSize: 16,fontWeight:FontWeight.w600 ))),
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
                        onChanged: searchStringChange,
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
          itemCount: schoolelection.length-1,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () async {
                int myInt = int.parse(schoolelection[index+1]['index']!);
                print(int.parse(schoolelection[index+1]['index']!).runtimeType);
                await SchoolDio.SchoolUrlDio(myInt);
                toHomePage(context, 0);
              },
              title: Text(schoolelection[index+1]['school']!,style: TextStyle(color: Colors.black),),
              subtitle: const Divider(
                color: Colors.black12,
                thickness: 1,
              ),
            );
          },
        )
    );
  }
}



