import 'package:flutter/material.dart';
import 'drawer_button.dart';
import '../config/config.dart';

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
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.119,
            padding: EdgeInsets.fromLTRB(18, MediaQuery.of(context).padding.top, 18, 0),
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
                        '       设置',
                        style:
                            TextStyle(fontSize: UIConfig.fontSizeTitle * 1.2),
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
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 24.0, 12.0, 0),
                              child: Container(
                                padding: EdgeInsets.all(UIConfig.paddingAll),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        UIConfig.borderRadiusEntry),
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                child: const Column(
                                  children: [
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.009),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                padding: EdgeInsets.all(UIConfig.paddingAll),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        UIConfig.borderRadiusEntry),
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                child: const Column(
                                  children: [
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
                                    Divider(
                                      color: Colors.black12,
                                      thickness: 1,
                                    ),
                                    QQButton(),
                                  ],
                                ),
                              ),
                            ),
                            const PolicyButton()
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
