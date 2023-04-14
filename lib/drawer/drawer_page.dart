import 'package:cumt_login/drawer/backgroundimage/imageselect.dart';
import 'package:cumt_login/drawer/theme/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';

import '../config.dart';
import 'aboutUs/pages/about_page.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary == Colors.blue
            ? const Color.fromRGBO(230, 231, 233, 1)
            : Theme
            .of(context)
            .colorScheme
            .background,
        child: Column(
          children: [
            Container(
              height: 250,
              color: const Color.fromRGBO(230, 231, 233, 1), // 设置Container的颜色
              child: const UserAccountsDrawerHeader(
                accountName: null,
                accountEmail: null,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    scale: 1.5,
                    image: AssetImage('images/logo1.png'),
                  ),
                ),
              ),
            ),Padding(
                  padding: EdgeInsets.all(UIConfig.paddingAll),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color:
                          Theme
                              .of(context)
                              .colorScheme
                              .primary == Colors.blue
                              ? Colors.grey.shade300
                              : Theme
                              .of(context)
                              .colorScheme
                              .primary,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(8, 8),
                              color:
                              Theme
                                  .of(context)
                                  .brightness == Brightness.dark
                                  ? const Color(0xFF383837).withAlpha(255)
                                  : Colors.black38,
                              blurRadius: 15,
                            ),
                            BoxShadow(
                              offset: const Offset(-8, -8),
                              color:
                              Theme
                                  .of(context)
                                  .brightness == Brightness.dark
                                  ? const Color(0xFF4c4c4b).withAlpha(255)
                                  : Colors.white70,
                              blurRadius: 15,
                            )
                          ]),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .86,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          GFAccordion(
                              collapsedTitleBackgroundColor:
                              Theme
                                  .of(context)
                                  .colorScheme
                                  .primary ==
                                  Colors.blue
                                  ? Colors.grey.shade300
                                  : Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                              expandedTitleBackgroundColor:
                              Theme
                                  .of(context)
                                  .colorScheme
                                  .primary ==
                                  Colors.blue
                                  ? Colors.grey.shade300
                                  : Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                              contentBackgroundColor:
                              Theme
                                  .of(context)
                                  .colorScheme
                                  .primary ==
                                  Colors.blue
                                  ? Colors.grey.shade300
                                  : Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                              titleChild: Text('个性化',
                                  style: TextStyle(
                                      fontSize: UIConfig.fontSizeMain*1.2)),
                              collapsedIcon:
                              Icon(Icons.keyboard_arrow_down_rounded, size: UIConfig.fontSizeMin * 2.5,),
                              expandedIcon:
                              Icon(Icons.keyboard_arrow_up_rounded, size: UIConfig.fontSizeMin * 2.5,),
                              contentChild: SizedBox(
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: 370,
                                        height: 58,
                                        child: Container(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .primary ==
                                              Colors.blue
                                              ? Colors.grey.shade300
                                              : Theme
                                              .of(context)
                                              .colorScheme
                                              .primary,
                                          padding: EdgeInsets.all(UIConfig.paddingAll),
                                          child: Row(
                                            children: [
                                              // 左侧图标
                                              Expanded(
                                                child: Text('更换背景',
                                                    style: TextStyle(
                                                        fontSize: UIConfig
                                                            .fontSizeMain*1.2)), // 中间文本
                                              ),
                                              ImageSelect(child: Icon(Icons.keyboard_arrow_right_rounded, size: UIConfig.fontSizeMin * 2.5,),)
                                              // 右侧图标
                                            ],
                                          ),
                                        )),
                                    const Divider(
                                      thickness: 2,
                                      color: Colors.white,
                                    ),

                                    SizedBox(
                                        width: 370,
                                        height: 58,
                                        child: Container(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .primary ==
                                              Colors.blue
                                              ? Colors.grey.shade300
                                              : Theme
                                              .of(context)
                                              .colorScheme
                                              .primary,
                                          padding: EdgeInsets.all(UIConfig.paddingAll),
                                          child: Row(
                                            children: [
                                              // 左侧图标
                                              Expanded(
                                                child: Text('删除背景',
                                                    style: TextStyle(
                                                        fontSize: UIConfig
                                                            .fontSizeMain*1.2)), // 中间文本
                                              ),
                                              ImageDelete(child: Icon(Icons.keyboard_arrow_right_rounded, size: UIConfig.fontSizeMin * 2.5,),)
                                              // 右侧图标
                                            ],
                                          ),
                                        )),
                                    const Divider(
                                      thickness: 2,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 370,
                                      height: 58,
                                      child: Container(
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .primary ==
                                            Colors.blue
                                            ? Colors.grey.shade300
                                            : Theme
                                            .of(context)
                                            .colorScheme
                                            .primary,
                                        padding: EdgeInsets.all(UIConfig.paddingAll),
                                        child: Row(
                                          children: [Text('主题颜色',
                                              style: TextStyle(
                                                  fontSize: UIConfig
                                                      .fontSizeMain*1.2)), // 中间文本
                                            const SizedBox(width: 40),
                                            Expanded(child: ThemeButton())
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                          const Divider(
                            indent: 10,
                            endIndent: 9,
                            thickness: 2,
                            color: Colors.white,
                          ),
                          InkWell(
                            onTap: () {
                              toAboutPage(context);
                            },
                            child: SizedBox(
                              width: 370,
                              child: Padding(
                                padding: EdgeInsets.all(UIConfig.paddingAll*5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text('关于我们',
                                            style: TextStyle(
                                                fontSize: UIConfig
                                                    .fontSizeMain*1.2)),
                                    ),
                                    Icon(Icons.keyboard_arrow_right_rounded, size: UIConfig.fontSizeMin * 2.5,),
                                  ],
                                )
                              ),
                            ),
                          )
                        ],
                      ))),
          ],
        ));
  }
}
