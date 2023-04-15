import 'package:cumt_login/drawer/theme/theme_color.dart';
import 'package:cumt_login/update/app_upgrade.dart';
import 'package:cumt_login/feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config.dart';
import 'aboutUs/pages/about_page.dart';
import 'backgroundimage/imageselect.dart';

class DrawerButton extends StatefulWidget {
  const DrawerButton({
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
          width: 370,
          child: Padding(
              padding: EdgeInsets.all(UIConfig.paddingAll * 3),
              child: Row(
                children: [
                  Expanded(
                    child: Text("关于我们",
                        style:
                            TextStyle(fontSize: UIConfig.fontSizeMain * 1.2)),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: UIConfig.fontSizeMin * 2.5,
                  ),
                ],
              )),
        ));
  }
}

class ImageButton extends StatefulWidget {
  final String text;
  const ImageButton({Key? key, required this.text}) : super(key: key);

  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 370,
        height: 58,
        child: Container(
          color: Theme.of(context).colorScheme.primary == Colors.blue
              ? Colors.grey.shade300
              : Theme.of(context).cardColor,
          padding: EdgeInsets.all(UIConfig.paddingAll * 3),
          child: Row(
            children: [
              Expanded(
                child: Text(widget.text,
                    style: TextStyle(
                        fontSize: UIConfig.fontSizeMain * 1.2)), // 中间文本
              ),
              ImageSelect(
                child: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  size: UIConfig.fontSizeMin * 2.5,
                ),
              )
            ],
          ),
        ));
  }
}

class ThemeButton extends StatefulWidget {
  final ThemeData themeData;
  final String text;
  const ThemeButton({Key? key, required this.themeData, required this.text}) : super(key: key);

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ImageDeleteButtonState extends State<ImageDeleteButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 370,
        height: 58,
        child: Container(
          color: Theme.of(context).colorScheme.primary == Colors.blue
              ? Colors.grey.shade300
              : Theme.of(context).cardColor,
          padding: EdgeInsets.all(UIConfig.paddingAll * 3),
          child: Row(
            children: [
              Expanded(
                child: Text('删除背景',
                    style: TextStyle(
                        fontSize: UIConfig.fontSizeMain * 1.2)), // 中间文本
              ),
              ImageDelete(
                child: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  size: UIConfig.fontSizeMin * 2.5,
                ),
              )
            ],
          ),
        ));
  }
}

class LightThemeButton extends StatefulWidget {
  const LightThemeButton({Key? key}) : super(key: key);

  @override
  State<LightThemeButton> createState() => _LightThemeButtonState();
}

class _LightThemeButtonState extends State<LightThemeButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Provider.of<ThemeProvider>(context, listen: false)
              .setThemeData(widget.themeData);
        },
        child: SizedBox(
          width: 370,
          child: Padding(
              padding: EdgeInsets.all(UIConfig.paddingAll * 3),
              child: Row(
                children: [
                  Expanded(
                    child: Text("日间模式",
                        style:
                            TextStyle(fontSize: UIConfig.fontSizeMain * 1.2)),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: UIConfig.fontSizeMin * 2.5,
                  ),
                ],
              )),
        ));
  }
}

class DarkThemeButton extends StatefulWidget {
  const DarkThemeButton({Key? key}) : super(key: key);

  @override
  State<DarkThemeButton> createState() => _DarkThemeButtonState();
}

class _DarkThemeButtonState extends State<DarkThemeButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Provider.of<ThemeProvider>(context, listen: false)
              .setThemeData(AppTheme.darkTheme().themeData);
        },
        child: SizedBox(
          width: 370,
          child: Padding(
              padding: EdgeInsets.all(UIConfig.paddingAll * 3),
              child: Row(
                children: [
                  Expanded(
                    child: Text("黑夜模式",
                        style:
                            TextStyle(fontSize: UIConfig.fontSizeMain * 1.2)),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: UIConfig.fontSizeMin * 2.5,
                  ),
                ],
              )),
        ));
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
          checkUpgrade(context);
        },
        child: SizedBox(
          width: 370,
          child: Padding(
              padding: EdgeInsets.all(UIConfig.paddingAll * 3),
              child: Row(
                children: [
                  Expanded(
                    child: Text("软件更新",
                        style:
                            TextStyle(fontSize: UIConfig.fontSizeMain * 1.2)),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: UIConfig.fontSizeMin * 2.5,
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
                title: Text('意见反馈'),
                content: FeedbackForm(),
              );
            },
          );
        },
        child: SizedBox(
          width: 370,
          child: Padding(
              padding: EdgeInsets.all(UIConfig.paddingAll * 3),
              child: Row(
                children: [
                  Expanded(
                    child: Text("反馈与建议",
                        style:
                            TextStyle(fontSize: UIConfig.fontSizeMain * 1.2)),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: UIConfig.fontSizeMin * 2.5,
                  ),
                ],
              )),
        ));
  }
}
