import 'package:cumt_login/settings/theme/theme_color.dart';
import 'package:cumt_login/settings/update/app_upgrade2.dart';
import 'package:cumt_login/settings/update/update_Alert_Icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_share/flutter_share.dart';

import '../config.dart';
import 'aboutUs/pages/about_page.dart';
import 'feedback/feedback.dart';
import 'help/help_page.dart';

class AboutButton extends StatefulWidget {
  const AboutButton({
    Key? key,
  }) : super(key: key);

  @override
  State<AboutButton> createState() => _AboutButtonState();
}

class _AboutButtonState extends State<AboutButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          toAboutPage(context);
        },
        child: SizedBox(
          child: Padding(
              padding: EdgeInsets.all(UIConfig.paddingAll * 1.2),
              child: Row(
                children: [
                  Expanded(
                    child: Text("关于我们",
                        style: TextStyle(fontSize: UIConfig.fontSizeMain)),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: UIConfig.fontSizeMin * 2,
                  ),
                ],
              )),
        ));
  }
}

class ThemeChange extends StatefulWidget {
  const ThemeChange({Key? key}) : super(key: key);

  @override
  State<ThemeChange> createState() => _ThemeChangeState();
}

class _ThemeChangeState extends State<ThemeChange> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
          padding: EdgeInsets.all(UIConfig.paddingAll * 1.2),
          child: Row(
            children: [
              Expanded(
                child: Text('深色模式',
                    style: TextStyle(fontSize: UIConfig.fontSizeMain)),
              ),
              Transform.scale(
                scale:0.65,
                child: CupertinoSwitch(
                  value: _switchValue,
                  onChanged: (bool val) {
                    setState(() {
                      _switchValue = val;
                      Provider.of<ThemeProvider>(context, listen: false)
                          .setThemeData(_switchValue?AppTheme.darkTheme().themeData:AppTheme.LightTheme().themeData);
                    });
                  },
                  trackColor: Colors.grey,
                  activeColor: Color.fromRGBO(74, 114, 176, 1),
                ),
              ),
            ],
          )),
    );
  }
}

class PhomeTheme extends StatefulWidget {
  const PhomeTheme({Key? key}) : super(key: key);

  @override
  State<PhomeTheme> createState() => _PhomeThemeState();
}

class _PhomeThemeState extends State<PhomeTheme> {
  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    // 获取手机系统的亮暗模式设置
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return SizedBox(
      child: Padding(
          padding: EdgeInsets.all(UIConfig.paddingAll * 1.2),
          child: Row(
            children: [
              Expanded(
                child: Text('跟随系统',
                    style: TextStyle(fontSize: UIConfig.fontSizeMain)),
              ),
              Transform.scale(
                scale:0.65,
                child: CupertinoSwitch(
                  value: _switchValue,
                  onChanged: (bool val) {
                    setState(() {
                      print(brightness);
                      _switchValue = val;
                      _switchValue?Provider.of<ThemeProvider>(context, listen: false)
                          .setThemeData(brightness==Brightness.dark?AppTheme.darkTheme().themeData:AppTheme.LightTheme().themeData):null;
                    });
                  },
                  trackColor: Colors.grey,
                  activeColor: Color.fromRGBO(74, 114, 176, 1),
                ),
              ),
            ],
          )),
    );
  }
}


class UpdatecheckButton extends StatefulWidget {
  const UpdatecheckButton({Key? key}) : super(key: key);

  @override
  State<UpdatecheckButton> createState() => _UpdatecheckButtonState();
}

class _UpdatecheckButtonState extends State<UpdatecheckButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Update.checkNeedUpdate(context, auto: false).then((_) {
            if (Update.isUpDate == true) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return UpgradeDialog2();
                  });
            }
          });
        },
        child: SizedBox(
          child: Padding(
              padding: EdgeInsets.all(UIConfig.paddingAll * 1.2),
              child: Row(
                children: [
                  Expanded(
                    child: Text("软件更新",
                        style: TextStyle(fontSize: UIConfig.fontSizeMain)),
                  ),
                  if (Update.isIgnore == true && Update.isUpDate == true)
                    Expanded(
                      child: UpdateAlertIcon(),
                    ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: UIConfig.fontSizeMin * 2,
                  ),
                ],
              )),
        ));
  }
}

class FeedBackButton extends StatefulWidget {
  const FeedBackButton({Key? key}) : super(key: key);

  @override
  State<FeedBackButton> createState() => _FeedBackButtonState();
}

class _FeedBackButtonState extends State<FeedBackButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(UIConfig.borderRadiusBox)),
                backgroundColor: Theme.of(context).colorScheme.background,
                title: Text('意见反馈'),
                content: FeedbackForm(),
              );
            },
          );
        },
        child: SizedBox(
          child: Padding(
              padding: EdgeInsets.all(UIConfig.paddingAll * 1.2),
              child: Row(
                children: [
                  Expanded(
                    child: Text("反馈与建议",
                        style: TextStyle(fontSize: UIConfig.fontSizeMain)),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: UIConfig.fontSizeMin * 2,
                  ),
                ],
              )),
        ));
  }
}

class HelpButton extends StatefulWidget {
  final Color color;

  HelpButton({Key? key, required this.color}) : super(key: key);

  @override
  State<HelpButton> createState() => _HelpButtonState();
}

class _HelpButtonState extends State<HelpButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          toHelpPage(context);
        },
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.all(UIConfig.paddingAll * 1.2),
            child: Icon(
              Icons.help_outline_sharp,
              color: widget.color,
              size: UIConfig.fontSizeMin * 2.04,
            ),
          ),
        ));
  }
}

class ShareApp extends StatefulWidget {
  const ShareApp({Key? key}) : super(key: key);

  @override
  State<ShareApp> createState() => _ShareAppState();
}

class _ShareAppState extends State<ShareApp> {
  Future<void> shareTextToWechatAndQQ(String text) async {
    try {
      await FlutterShare.share(
        title: 'Share Text',
        text: text,
      );
    } catch (e) {
      print('Error sharing text: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          shareTextToWechatAndQQ('欢迎使用校园网自动登录app，下载地址：https://wwya.lanzoub.com/i9H4A0uesqxc(Android)/https://testflight.apple.com/join/lTBgteBv(iOS)');
        },
        child: SizedBox(
          child: Padding(
              padding: EdgeInsets.all(UIConfig.paddingAll * 1.2),
              child: Row(
                children: [
                  Expanded(
                    child: Text("分享App",
                        style: TextStyle(fontSize: UIConfig.fontSizeMain)),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: UIConfig.fontSizeMin * 2,
                  ),
                ],
              )),
        ));
  }
}
