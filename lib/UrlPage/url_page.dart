import 'package:cumt_login/UrlPage/school_url.dart';
import 'package:cumt_login/UrlPage/shortcut/ui.dart';
import 'package:flutter/material.dart';

import '../config.dart';
import '../settings/drawer_button.dart';

toUrlPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => UrlPage(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class UrlPage extends StatefulWidget {
  UrlPage({Key? key}) : super(key: key);

  @override
  State<UrlPage> createState() => _UrlPageState();
}

class _UrlPageState extends State<UrlPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245,244,249,1),
      body: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.117,
              color: Color.fromRGBO(74, 114, 176, 1),
              child: Column(
                children: [
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          '        校园网自动登录',
                          style:
                          TextStyle(fontSize: UIConfig.fontSizeTitle * 1.2,color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      HelpButton(color: Colors.white,),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.0205,
                  ),
                 Shortcut(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.0205,
                  ),
                  SchoolUrl(),
                ],
              ),
            ),
          ],
        ),
      ),);
  }
}
