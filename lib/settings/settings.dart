import 'package:flutter/material.dart';
import 'drawer_button.dart';
import '../config.dart';

toSettingPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const SettingPage(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

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
                  color: Theme.of(context).colorScheme.primary,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(222, 221, 251, 0.5),
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
                            '        校园网自动登录',
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
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 0),
                          child: Container(
                            padding: EdgeInsets.all(UIConfig.paddingAll),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(UIConfig.borderRadiusEntry),
                                color: Theme.of(context).colorScheme.primary),
                            child: Column(
                              children: const [
                                ThemeChange(),
                                Divider(
                                  color: Colors.black12,
                                  thickness: 1,
                                ),
                                PhomeTheme()
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.009),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            padding: EdgeInsets.all(UIConfig.paddingAll),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(UIConfig.borderRadiusEntry),
                                color: Theme.of(context).colorScheme.primary),
                            child: Column(
                              children: const [
                                AboutButton(),
                                Divider(
                                  color: Colors.black12,
                                  thickness: 1,
                                ),
                                FeedBackButton(),
                                Divider(
                                  color: Colors.black12,
                                  thickness: 1,
                                ),
                                ShareApp(),
                                Divider(
                                  color: Colors.black12,
                                  thickness: 1,
                                ),
                                UpdatecheckButton(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),);
  }
}
