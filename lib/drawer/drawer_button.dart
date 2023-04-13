import 'package:cumt_login/drawer/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config.dart';
import 'aboutUs/pages/about_page.dart';
import 'backgroundimage/imageselect.dart';
class DrawerButton extends StatefulWidget {
  const DrawerButton({Key? key, }) : super(key: key);

  @override
  State<DrawerButton> createState() => _DrawerButtonState();
}

class _DrawerButtonState extends State<DrawerButton> {
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

class ImageSelectButton extends StatefulWidget {
  const ImageSelectButton({Key? key}) : super(key: key);

  @override
  State<ImageSelectButton> createState() => _ImageSelectButtonState();
}

class _ImageSelectButtonState extends State<ImageSelectButton> {
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
                child: Text('更换背景',
                    style: TextStyle(
                        fontSize: UIConfig
                            .fontSizeMain*1.2)), // 中间文本
              ),
              ImageSelect(child: Icon(Icons.keyboard_arrow_right_rounded, size: UIConfig.fontSizeMin * 2.5,),)
            ],
          ),
        ));
  }
}

class ImageDeleteButton extends StatefulWidget {
  const ImageDeleteButton({Key? key}) : super(key: key);

  @override
  State<ImageDeleteButton> createState() => _ImageDeleteButtonState();
}

class _ImageDeleteButtonState extends State<ImageDeleteButton> {
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
                child: Text('删除背景',
                    style: TextStyle(
                        fontSize: UIConfig
                            .fontSizeMain*1.2)), // 中间文本
              ),
              ImageDelete(child: Icon(Icons.keyboard_arrow_right_rounded, size: UIConfig.fontSizeMin * 2.5,),)
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
              .setThemeData(ThemeData.light());
        },
        child: SizedBox(
          width: 370,
          child: Padding(
              padding: EdgeInsets.all(UIConfig.paddingAll*3),
              child: Row(
                children: [
                  Expanded(
                    child: Text("日间模式",style: TextStyle( fontSize: UIConfig .fontSizeMain * 1.2)),
                  ),
                  Icon(Icons.keyboard_arrow_right_rounded,size: UIConfig.fontSizeMin * 2.5,),
                ],
              )
          ),
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
              padding: EdgeInsets.all(UIConfig.paddingAll*3),
              child: Row(
                children: [
                  Expanded(
                    child: Text("黑夜模式",
                        style: TextStyle(fontSize: UIConfig.fontSizeMain * 1.2)),
                  ),
                  Icon(Icons.keyboard_arrow_right_rounded, size: UIConfig.fontSizeMin * 2.5,),
                ],
              )
          ),
        ));
  }
}
