import 'package:cumt_login/UrlPage/shortcut/ui.dart';
import 'package:flutter/material.dart';

import '../config.dart';
import '../settings/drawer_button.dart';

toUrlPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const UrlPage(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class UrlPage extends StatefulWidget {
  const UrlPage({Key? key}) : super(key: key);

  @override
  State<UrlPage> createState() => _UrlPageState();
}

class _UrlPageState extends State<UrlPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardTheme.color,
      body: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.119,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                color: Theme.of(context).colorScheme.primary,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).brightness != Brightness.dark
                        ? const Color.fromRGBO(59, 114, 217, 0.2)
                        : Colors.black38,
                    spreadRadius: 12,
                    blurRadius: 18,
                    offset: Offset.zero, // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          '        常用链接',
                          style: TextStyle(
                              fontSize: UIConfig.fontSizeTitle * 1.2),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      HelpButton(),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0105,
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 24.0, 0, 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.0205,
                    ),
                    const Shortcut(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.0205,
                    ),
                    //const SchoolUrl(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
