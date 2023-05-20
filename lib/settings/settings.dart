import 'package:flutter/material.dart';
import 'drawer_button.dart';
import 'theme/theme_color.dart';
import '../config.dart';

toSettingPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => SettingPage(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245,244,249,1),
        body: Center(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.1,
                color: Color.fromRGBO(73,114,175,1),
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
                              children: [
                                ThemeButton(
                                  themeData: AppTheme.LightTheme().themeData,
                                  text: "日间模式",
                                ),
                                const Divider(
                                  color: Colors.black12,
                                  thickness: 1,
                                ),
                                ThemeButton(
                                  themeData: AppTheme.darkTheme().themeData,
                                  text: "黑夜模式",
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
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
