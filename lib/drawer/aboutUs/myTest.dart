import 'package:cumt_login/drawer/aboutUs/pages/about_page.dart';
import 'package:cumt_login/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/bottom_sheet/gf_bottom_sheet.dart';

import '../../config.dart';


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
          /// 我的建议是，这个【关于我们】页面用两套主题足够了
          /// 一套在ThemeData.dark()时的夜间主题，一套默认主题，就跟矿小助一样
          // theme: ThemeData.dark(),
          home: child,
        );
      },
      child: const AboutPage(),
    );
  }
}
