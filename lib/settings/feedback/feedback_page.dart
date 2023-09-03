import 'package:cumt_login/settings/update/toast.dart';
import 'package:dio/dio.dart';

import '../../config.dart';
import 'package:flutter/material.dart';
import '../../login_util/prefs.dart';
import '../drawer_button.dart';
import 'imagePickButton.dart';

toFeedBackPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => FeedBackPage(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class FeedBackPage extends StatefulWidget {
  FeedBackPage({Key? key}) : super(key: key);
  static List<String> imageList = [];

  @override
  State<FeedBackPage> createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  final TextEditingController _textEditingController_title =
      TextEditingController();
  final TextEditingController _textEditingController_decription =
      TextEditingController();

  String title="";
  String text="";
  String imageCode="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardTheme.color,
      body: GestureDetector(
      onHorizontalDragUpdate: (details) {
      // 当用户向左滑动时，触发handleSwipeLeft函数
      if (details.primaryDelta! < -10) {
      () => Navigator.pop(context);
      }
      },
    child:Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.119,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                boxShadow: [
                  BoxShadow(
                    color:Theme.of(context).brightness != Brightness.dark
                        ? const Color.fromRGBO(59, 114, 217, 0.2)
                        : Colors.black38,
                    spreadRadius: 12,
                    blurRadius: 18,
                    offset: Offset.zero, // changes position of shadow
                  ),
                ],
              ),
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
                          child: Center(
                            child: Text(
                              '帮助与反馈',
                              style: TextStyle(
                                  fontSize: UIConfig.fontSizeTitle * 1.2),
                              textAlign: TextAlign.center,
                            ),
                          )),
                      HelpButton(),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0105,
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(UIConfig.paddingAll, UIConfig.paddingAll, UIConfig.paddingAll, 0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 45,
                            child: TextField(
                              controller: _textEditingController_title,
                              style: const TextStyle(color: Colors.grey),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(left:13,bottom: -3),
                                hintText: '请输入问题的标题',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide.none,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 24.0, 0, 0),
                    child: Container(
                      padding: EdgeInsets.all(UIConfig.paddingAll),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 87,
                            child: TextField(
                              controller: _textEditingController_decription,
                              maxLines: 10,
                              minLines: 1,
                              decoration: const InputDecoration(
                                hintText: '请描述一下你遇到的场景和问题',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide.none,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 24.0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: const Text(
                            '    图片(提供问题截图，能帮助我们更快定位并解决问题~)',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary),
                          child: Row(
                            children: [
                              Expanded(
                                child: MyWidget(),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),),
      bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height * 0.0898,
          child: Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 335,
                height: 43,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(UIConfig.borderRadiusEntry),
                  color: const Color.fromRGBO(59, 114, 217, 0.9),
                ),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("提示"),
                        content: const Text("你可以加入内测交流群：738340698\n与我们进行交流和获得解决方法"),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () async {
                              title=_textEditingController_title.text;
                              text=_textEditingController_decription.text;
                              var dio = Dio();
                              var url = "http://47.115.228.176:8080/schoollink/feed";
                              try {
                                var response = await dio.put(url, data: {
                                  'title': title,
                                  'content': text,
                                  'imageCode':'1'
                                });
                              } catch (e) {
                                print('PUT request failed: $e');
                                if (e is DioError) {
                                  print('DioError: ${e.response?.data}');
                                }
                              }
                              FeedBackPage.imageList.clear();
                              Navigator.of(context).pop();
                              showToast('提交成功');
                              Navigator.of(context).pop();
                            },
                            child: const Text("关闭"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Center(
                    child: Text(
                      '提交',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
