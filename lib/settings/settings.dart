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
      backgroundColor: const Color.fromRGBO(245,244,249,1),
        body: Center(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.117,
                color: const Color.fromRGBO(74, 114, 176, 1),
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
                    const SizedBox(
                      height: 10,
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
                          padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0),
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
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
