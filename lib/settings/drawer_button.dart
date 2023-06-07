import 'package:cumt_login/settings/feedback/feedback_page.dart';
import 'package:cumt_login/settings/theme/theme_color.dart';
import 'package:cumt_login/settings/update/app_upgrade2.dart';
import 'package:cumt_login/settings/update/update_Alert_Icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../login_util/prefs.dart';
import 'aboutUs/pages/about_page.dart';
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
          height: MediaQuery.of(context).size.height*0.045,
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

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.045,
      child: Padding(
          padding: EdgeInsets.all(UIConfig.paddingAll * 1.2),
          child: Row(
            children: [
              Expanded(
                child: Text('深色模式',
                    style: TextStyle(fontSize: UIConfig.fontSizeMain)),
              ),
              FlutterSwitch(
                padding: 1,
                toggleSize: 20,
                inactiveColor: Colors.grey,
                activeColor: Color.fromRGBO(74, 114, 176, 1),
                value: Theme.of(context).brightness==Brightness.dark?true:false,
                width: 40,
                height: 20,
                onToggle: (bool val) {
                  setState(() {
                    Prefs.theme='false';
                    print(MediaQuery.of(context).size.height*0.0576);
                    Provider.of<ThemeProvider>(context, listen: false)
                        .setThemeData(val
                            ? AppTheme.darkTheme().themeData
                            : AppTheme.LightTheme().themeData);
                  });
                },
              )
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

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.045,
      child: Padding(
          padding: EdgeInsets.all(UIConfig.paddingAll * 1.2),
          child: Row(
            children: [
              Expanded(
                child: Text('跟随系统',
                    style: TextStyle(fontSize: UIConfig.fontSizeMain)),
              ),
              FlutterSwitch(
                padding: 1,
                toggleSize: 20,
                inactiveColor: Colors.grey,
                activeColor: Color.fromRGBO(74, 114, 176, 1),
                value: Prefs.theme=='true'?true:false,
                width: 40,
                height: 20,
                onToggle: (bool val) {
                  setState(() {
                    print(brightness);
                    Prefs.theme=val.toString();
                    print(Prefs.theme);
                  });
                },
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
          height: MediaQuery.of(context).size.height*0.045,
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
//
// AlertDialog(
// shape: RoundedRectangleBorder(
// borderRadius:
// BorderRadius.circular(UIConfig.borderRadiusBox)),
// backgroundColor: Theme.of(context).colorScheme.background,
// title: Text('意见反馈'),
// content: FeedbackForm(),

class _FeedBackButtonState extends State<FeedBackButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
            toFeedBackPage(context);
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height*0.045,
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

  HelpButton({Key? key}) : super(key: key);

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
          height: MediaQuery.of(context).size.height*0.045,
          child: Padding(
            padding: EdgeInsets.all(UIConfig.paddingAll * 1.2),
            child: Icon(
              Icons.help_outline_sharp,
              color: const Color.fromRGBO(59, 114, 217, 1),
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
          shareTextToWechatAndQQ(
              '欢迎使用校园网自动登录app，下载地址：https://wwya.lanzoub.com/i9H4A0uesqxc(Android)/https://testflight.apple.com/join/lTBgteBv(iOS)');
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height*0.045,
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
