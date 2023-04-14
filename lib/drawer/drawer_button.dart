import 'package:cumt_login/drawer/theme/theme_color.dart';
import 'package:cumt_login/update/app_upgrade.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config.dart';
import 'aboutUs/pages/about_page.dart';

class AboutButton extends StatefulWidget {
  const AboutButton({Key? key, }) : super(key: key);

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
              padding: EdgeInsets.all(UIConfig.paddingAll*3),
              child: Row(
                children: [
                  Expanded(
                    child: Text("关于我们", style: TextStyle( fontSize: UIConfig.fontSizeMain * 1.2)),
                  ),
                  Icon(Icons.keyboard_arrow_right_rounded,size: UIConfig.fontSizeMin * 2.5,),
                ],
              )
          ),
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
          color: Theme.of(context).colorScheme.primary == Colors.blue ? Colors.grey.shade300 : Theme.of(context).cardColor,
          padding: EdgeInsets.all(UIConfig.paddingAll*3),
          child: Row(
            children: [
              Expanded(
                child: Text(widget.text,
                    style: TextStyle(
                        fontSize: UIConfig
                            .fontSizeMain*1.2)), // 中间文本
              ),
              Icon(Icons.keyboard_arrow_right_rounded, size: UIConfig.fontSizeMin * 2.5,),
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

class _ThemeButtonState extends State<ThemeButton> {
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
              padding: EdgeInsets.all(UIConfig.paddingAll*3),
              child: Row(
                children: [
                  Expanded(
                    child: Text(widget.text,style: TextStyle( fontSize: UIConfig .fontSizeMain * 1.2)),
                  ),
                  Icon(Icons.keyboard_arrow_right_rounded,size: UIConfig.fontSizeMin * 2.5,),
                ],
              )
          ),
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
              padding: EdgeInsets.all(UIConfig.paddingAll*3),
              child: Row(
                children: [
                  Expanded(
                    child: Text("软件更新",style: TextStyle( fontSize: UIConfig .fontSizeMain * 1.2)),
                  ),
                  Icon(Icons.keyboard_arrow_right_rounded,size: UIConfig.fontSizeMin * 2.5,),
                ],
              )
          ),
        ));
  }
}