import 'package:cumt_login/drawer/theme/theme_color.dart';
import 'package:cumt_login/drawer/update/app_upgrade2.dart';
import 'package:cumt_login/drawer/update/update_Alert_Icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config.dart';
import 'aboutUs/pages/about_page.dart';
import 'feedback/feedback.dart';
import 'help/help_page.dart';

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
          width: MediaQuery.of(context).size.width*0.7,
          height: MediaQuery.of(context).size.height*0.07,
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
        width: MediaQuery.of(context).size.width*0.7,
        height: MediaQuery.of(context).size.height*0.07,
        child: Container(
          color: Theme.of(context).colorScheme.background,
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
          width: MediaQuery.of(context).size.width*0.7,
          height: MediaQuery.of(context).size.height*0.07,
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
          showDialog(context: context, builder: (BuildContext context){
            return UpgradeDialog2();
          });
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width*0.7,
          height: MediaQuery.of(context).size.height*0.07,
          child: Padding(
              padding: EdgeInsets.all(UIConfig.paddingAll*3),
              child: Row(
                children: [
                  Expanded(
                    child: Text("软件更新",style: TextStyle( fontSize: UIConfig .fontSizeMain * 1.2)),
                  ),
                  if (Update.isIgnore==true)
                    Expanded(
                      child: UpdateAlertIcon(),
                  ),
                  Icon(Icons.keyboard_arrow_right_rounded,size: UIConfig.fontSizeMin * 2.5,),
                ],
              )
          ),
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
                    borderRadius: BorderRadius.circular(UIConfig.borderRadiusBox)),
                backgroundColor: Theme.of(context).colorScheme.background,
                title: Text('意见反馈'),
                content: FeedbackForm(),
              );
            },
          );
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width*0.7,
          height: MediaQuery.of(context).size.height*0.07,
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

class HelpButton extends StatefulWidget {
  const HelpButton({Key? key}) : super(key: key);

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
          width: MediaQuery.of(context).size.width*0.7,
          height: MediaQuery.of(context).size.height*0.07,
          child: Padding(
              padding: EdgeInsets.all(UIConfig.paddingAll*3),
              child: Row(
                children: [
                  Expanded(
                    child: Text("帮助", style: TextStyle( fontSize: UIConfig.fontSizeMain * 1.2)),
                  ),
                  Icon(Icons.keyboard_arrow_right_rounded,size: UIConfig.fontSizeMin * 2.5,),
                ],
              )
          ),
        ));
  }
}