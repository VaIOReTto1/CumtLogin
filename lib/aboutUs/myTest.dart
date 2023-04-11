

import 'package:cumt_login/aboutUs/pages/about_page.dart';
import 'package:cumt_login/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/bottom_sheet/gf_bottom_sheet.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

import '../config.dart';

main() {
  runApp(MaterialApp(home: testPage()));
}

class testPage extends StatefulWidget {
  const testPage({Key? key}) : super(key: key);

  @override
  State<testPage> createState() => _testPageState();
}

class _testPageState extends State<testPage> {


  final GFBottomSheetController _controller = GFBottomSheetController();


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(UIConfig.designWidth, UIConfig.designHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          /// 这里用来调试不同主题颜色对aboutUsPage的影响
          // theme: ThemeData.dark(),
          home: child,
        );
      },
      child: const AboutPage(),
    );
  }
}
