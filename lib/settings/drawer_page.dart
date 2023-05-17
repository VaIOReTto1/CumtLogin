import 'package:cumt_login/settings/backgroundimage/imageselect.dart';
import 'package:cumt_login/settings/drawer_button.dart';
import 'package:cumt_login/settings/theme/theme_color.dart';
import 'package:flutter/material.dart';
import '../config.dart';
import 'dart:io';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                height: 250,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Padding(
                  padding: EdgeInsets.all(UIConfig.paddingAll),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color:Theme.of(context).colorScheme.background,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(8, 8),
                              color:Theme.of(context).brightness == Brightness.dark ? const Color(0xFF383837).withAlpha(255) : Colors.black38,
                              blurRadius: 15,
                            ),
                            BoxShadow(
                              offset: const Offset(-8, -8),
                              color:Theme.of(context).brightness == Brightness.dark ? const Color(0xFF4c4c4b).withAlpha(255) : Colors.white70,
                              blurRadius: 15,
                            )
                          ]),
                      width: MediaQuery .of(context) .size.width * .86,
                      child:SingleChildScrollView(
                        child: Column(
                          children: [
                            Platform.isIOS||Platform.isAndroid?const ImageSelect(child: ImageButton(text: "更换背景")):Container(),
                            Platform.isIOS||Platform.isAndroid?const ImageDelete(child: ImageButton(text: "删除背景")):Container(),
                            ThemeButton(themeData: AppTheme.LightTheme().themeData,text: "日间模式",),
                            ThemeButton(themeData: AppTheme.darkTheme().themeData,text: "黑夜模式",),
                            const FeedBackButton(),
                            const UpdatecheckButton(),
                            const AboutButton(),
                            const HelpButton()
                          ],
                        ),
                      )
                  )),
          ],
        ));
  }
}
