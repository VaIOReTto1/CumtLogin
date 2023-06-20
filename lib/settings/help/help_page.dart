import 'package:flutter/material.dart';

import '../../config.dart';
import '../../icon.dart';
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
    final double screenWidth = MediaQuery.of(context).size.width;
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
              title: Text("帮助",
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              ),
              titleSpacing: screenWidth * 0.3,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: UIConfig.fontSizeMin * 0.1),
            sliver: SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.all(UIConfig.paddingAll + 10),
                child:SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Row(
                        children: [
                          const Icon(MyIcons.rectangle,size: 17,color: Color.fromRGBO(74, 114, 176, 1),),
                          Text("校园选择",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.6,
                            fontWeight: FontWeight.bold,),),
                        ],
                      ),
                      Text("      在初次登录页面搜索学校名称或者点击账号左边的校徽即可",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.4,)),
                      const SizedBox(height: 15,),

                      Row(
                        children: [
                          const Icon(MyIcons.rectangle,size: 17,color: Color.fromRGBO(74, 114, 176, 1),),
                          Text("登录失败",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.6,
                            fontWeight: FontWeight.bold,),),
                        ],
                      ),
                      Text("Android：\n      [WLAN] -> [WLAN助理] -> 关闭[网络选择] [双WLAN加速] [数据加速]（根据手机型号不同设置不同）\n      如果不能解决请尝试关掉数据只开WiFi",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.4,)),
                      Text("IOS：\n      关闭 [询问是否加入网络]",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.4,)),
                      const SizedBox(height: 15,),

                      Row(
                        children: [
                          const Icon(MyIcons.rectangle,size: 17,color: Color.fromRGBO(74, 114, 176, 1),),
                          Text("工具使用",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.6,
                            fontWeight: FontWeight.bold,),),
                        ],
                      ),
                      Text("      对卡片左滑可以编辑，右滑会删除卡片，增加入口时url必须为带https的完整链接",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.4,)),
                      const SizedBox(height: 15,),

                      Row(
                        children: [
                          const Icon(MyIcons.rectangle,size: 17,color: Color.fromRGBO(74, 114, 176, 1),),
                          Text("网速过慢",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.6,
                            fontWeight: FontWeight.bold,),),
                        ],
                      ),
                      Text("      请查看是否选择运营商",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.4,)),
                      const SizedBox(height: 15,),

                      Row(
                        children: [
                          const Icon(MyIcons.rectangle,size: 17,color: Color.fromRGBO(74, 114, 176, 1),),
                          Text("设备超限",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.6,
                            fontWeight: FontWeight.bold,),),
                        ],
                      ),
                      Text("      请从快捷入口点击用户自助服务系统撤销所有登录设备",style: TextStyle(fontSize: UIConfig.fontSizeSubMain*1.4,)),
                      const SizedBox(height: 15,),

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
