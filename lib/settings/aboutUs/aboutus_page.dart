import 'package:cumt_login/settings/update/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config.dart';
import '../../icon.dart';
import '../drawer_button.dart';

toAboutUsPage(BuildContext context) {
  Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
    return const AboutUsPage();
  }));
}

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardTheme.color,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.119,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              color: Theme.of(context).colorScheme.primary,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).brightness != Brightness.dark
                      ? const Color.fromRGBO(59, 114, 217, 0.2)
                      : Colors.black38,
                  spreadRadius: 12,
                  blurRadius: 18,
                  offset: Offset.zero, // changes position of shadow
                ),
              ],
            ),
            child: Align(
              alignment: Alignment.center, // 将内容在水平方向上居中
              child: Column(
                children: [
                  Expanded(child: Container()),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: UIConfig.fontSizeSubTitle * 2,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : const Color.fromRGBO(59, 114, 217, 1),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '关于我们',
                          style:
                              TextStyle(fontSize: UIConfig.fontSizeTitle * 1.2),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      HelpButton(),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0105,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              child: Center(
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Image(
                            image: const AssetImage('images/logo_modify.png'),
                            height: MediaQuery.of(context).size.height * 0.20,
                            width: MediaQuery.of(context).size.height * 0.23,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Row(
                          children: [
                            const Icon(
                              MyIcons.rectangle,
                              size: 25,
                              color: Color.fromRGBO(59, 114, 217, 1),
                            ),
                            Text(
                              "项目组",
                              style: TextStyle(
                                  fontSize: UIConfig.fontSizeSubTitle * 1.3),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            Group("叶典林", "22级大数据2班", "客户端组", "1302140648",
                                'https://qm.qq.com/cgi-bin/qm/qr?k=5oOH3MdCC4TuB-GRkMg5BJFO5mqRhcrk&noverify=0',
                                showblog:
                                    'https://blog.csdn.net/VaIOReTto1?spm=1000.2115.3001.5343',
                                showgithub: 'https://github.com/VaIOReTto1'),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 0.034,
                            ),
                            Group("许瑞熙", "21级会计3班", "产品组", "2073416698",
                                'https://qm.qq.com/q/cT6u49cqzK&personal_qrcode_source=4'),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            Group("冯梓晨", "22级计科3班", "客户端组", "1486008923",
                                'https://qm.qq.com/cgi-bin/qm/qr?k=5oOH3MdCC4TuB-GRkMg5BJFO5mqRhcrk&noverify=0',
                                showblog: 'https://w6rsty.github.io/',
                                showgithub: 'https://github.com/w6rsty'),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 0.034,
                            ),
                            Group("徐涛", "21级水文2班", "产品组", "1827900292",
                                'https://qm.qq.com/q/MHZWbQAtmS&personal_qrcode_source=3'),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            Group("蒋昀松", "22级大数据2班", "后端组", "2557978317",
                                'https://qm.qq.com/cgi-bin/qm/qr?k=5oOH3MdCC4TuB-GRkMg5BJFO5mqRhcrk&noverify=0',
                                showblog:
                                    'https://www.yuque.com/yuqueyonghuzk6ln0',
                                showgithub: 'https://github.com/Jyjays'),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 0.034,
                            ),
                            Group("汪子怡", "21级工设3班", "设计组", "1437212831",
                                'https://qm.qq.com/q/1sscx9pGla&personal_qrcode_source=3'),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            Group("孙志豪", "22级计科4班", "客户端组", "2930877510",
                                'https://qm.qq.com/cgi-bin/qm/qr?k=5oOH3MdCC4TuB-GRkMg5BJFO5mqRhcrk&noverify=0',
                                showblog: 'mirrso.icu',
                                showgithub:
                                    'https://github.com/xiangxinliao43'),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 0.034,
                            ),
                            Group("杨雅晴", "21级计科1班", "设计组", "641938243",
                                'https://qm.qq.com/q/2OZ8OzDzFm&personal_qrcode_source=4'),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            Group("唐嘉诣", "22级软工1班", "客户端组", "1665534874",
                                'https://qm.qq.com/cgi-bin/qm/qr?k=5oOH3MdCC4TuB-GRkMg5BJFO5mqRhcrk&noverify=0',
                                showblog:
                                    'https://blog.csdn.net/Oven_maizi?spm=1011.2480.3001.5343',
                                showgithub: 'https://github.com/sanwu-maizi'),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Row(
                          children: [
                            const Icon(
                              MyIcons.rectangle,
                              size: 25,
                              color: Color.fromRGBO(59, 114, 217, 1),
                            ),
                            Text(
                              "交流群",
                              style: TextStyle(
                                  fontSize: UIConfig.fontSizeSubTitle * 1.3),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            QQGroup("839372371", "交流1群"),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 0.034,
                            ),
                            QQGroup("957634136", "交流2群"),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            QQGroup("238908591", "交流3群"),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 0.034,
                            ),
                            QQGroup("738340698", "内测交流群"),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget Group(
      String name, String Class, String group, String qq, String qqlink,
      {showblog = "false", showgithub = "false"}) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                offset: const Offset(8, 8),
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF383837).withAlpha(255)
                    : Colors.black38,
                blurRadius: 15,
              ),
              BoxShadow(
                offset: const Offset(-8, -8),
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF4c4c4b).withAlpha(255)
                    : Colors.white70,
                blurRadius: 15,
              )
            ]),
        width: MediaQuery.of(context).size.width * 0.433,
        height: 85,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                children: [
                  CircleAvatar(
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(UIConfig.borderRadiusBox),
                      child: CachedNetworkImage(
                        imageUrl: "http://q1.qlogo.cn/g?b=qq&nk=$qq&s=640",
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  $name      ',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '   $Class\n   $group  ',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 10),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            launchUrl(Uri.parse(qqlink),
                                mode: LaunchMode.externalApplication);
                          },
                          child: const Icon(
                            MdiIcons.qqchat,
                            size: 23,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        if (showblog != 'false')
                          InkWell(
                              onTap: () {
                                launchUrl(Uri.parse(showblog),
                                    mode: LaunchMode.externalApplication);
                              },
                              child: const Icon(
                                Icons.location_history,
                                size: 23,
                              )),
                        const SizedBox(
                          width: 8,
                        ),
                        if (showgithub != 'false')
                          InkWell(
                            onTap: () {
                              launchUrl(Uri.parse(showgithub),
                                  mode: LaunchMode.externalApplication);
                            },
                            child: const Icon(
                              MdiIcons.github,
                              size: 23,
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget QQGroup(String qNumber, String name) {
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: qNumber)).then((_) {
          showToast('已复制到剪贴板');
        });
      },
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          // 当用户向左滑动时，触发handleSwipeLeft函数
          if (details.primaryDelta! < -10) {
            () => Navigator.pop(context);
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(8, 8),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF383837).withAlpha(255)
                      : Colors.black38,
                  blurRadius: 15,
                ),
                BoxShadow(
                  offset: const Offset(-8, -8),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF4c4c4b).withAlpha(255)
                      : Colors.white70,
                  blurRadius: 15,
                )
              ]),
          width: MediaQuery.of(context).size.width * 0.433,
          child: ListTile(
              leading: SizedBox(
                child: CircleAvatar(
                  // size: UIConfig.borderRadiusBox * 1.2,
                  backgroundImage: NetworkImage(
                      "http://p.qlogo.cn/gh/$qNumber/$qNumber/640/"),
                ),
              ),
              title: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: UIConfig.paddingVertical),
                child: const Text(
                  '点击复制群号',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10),
                ),
              )),
        ),
      ),
    );
  }
}
