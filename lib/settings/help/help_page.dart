import 'package:flutter/material.dart';

import '../../config.dart';
import '../aboutUs/cpns/single_info_card.dart';

toHelpPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => HelpPage(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class HelpPage extends StatelessWidget {
  HelpPage({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Theme.of(context).cardTheme.color,
        body:
            CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          SliverAppBar(
            centerTitle: false,
            pinned: true,
            floating: false,
            snap: false,
            primary: true,
            expandedHeight: height * .02,
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: UIConfig.fontSizeSubTitle * 2,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : const Color.fromRGBO(59, 114, 217, 1),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: UIConfig.fontSizeMin * 0.1),
            sliver: SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.all(UIConfig.paddingAll),
                child:SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Text("Q：当WIFI登录失败时，可能是以下原因",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.6,
                        fontWeight: FontWeight.bold,),),
                      Text("\nAndroid：\n      [WLAN] -> [WLAN助理] -> 关闭[网络选择] [双WLAN加速] [数据加速]（根据手机型号不同设置不同）\n      如果不能解决请尝试关掉数据只开WiFi",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.4,)),
                      Text("\nIOS：\n      关闭 [询问是否加入网络]\n",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.4,)),
                      Text("Q：快捷入口使用技巧",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.6,
                        fontWeight: FontWeight.bold,),),
                      Text("\n      对卡片左滑可以编辑，右滑会删除卡片，增加入口时url必须为带https的完整链接\n",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.4,)),
                      Text("Q：网络速度过慢",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.6,
                        fontWeight: FontWeight.bold,),),
                      Text("\n      请查看是否选择运营商\n",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.4,)),
                      Text("Q：登录设备超限",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.6,
                        fontWeight: FontWeight.bold,),),
                      Text("\n      请从快捷入口点击用户自助服务系统撤销所有登录设备\n",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.4,)),
                      Text("如果还不能解决，请加入qq群：738340698\n",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.4,fontWeight: FontWeight.bold,)),
                      const SizedBox(
                        height: 200,
                      )
                    ],
                  )
              )), //将原来的ListView中的children放在这里
            ),
          ),
        ]));
  }
}
