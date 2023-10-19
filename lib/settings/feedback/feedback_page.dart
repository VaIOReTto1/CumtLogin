import 'package:cumt_login/settings/update/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../config/config.dart';
import 'package:flutter/material.dart';
import '../drawer_button.dart';
import '../settings_appbar.dart';
import 'imagePickButton.dart';

toFeedBackPage(BuildContext context) {
  Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
    return const FeedBackPage();
  }));
}

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({Key? key}) : super(key: key);
  static List<String> imageList = [];

  @override
  State<FeedBackPage> createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  final TextEditingController _textEditingController_title =
      TextEditingController();
  final TextEditingController _textEditingController_decription =
      TextEditingController();

  String title = "";
  String text = "";
  String imageCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardTheme.color,
      body: Center(
        child: Column(
          children: [
            SettingsAppBar(title: "帮助与反馈"),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(UIConfig.paddingAll,
                          UIConfig.paddingAll, UIConfig.paddingAll, 0),
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
                                contentPadding:
                                    EdgeInsets.only(left: 13, bottom: -3),
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
                        const Text(
                          '    图片(提供问题截图，能帮助我们更快定位并解决问题~)',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary),
                          child: const Row(
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
      ),
      bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height * 0.0898,
          child: Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        content:
                            const Text("你可以加入内测交流群：738340698\n与我们进行交流和获得解决方法"),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () async {
                              title = _textEditingController_title.text;
                              text = _textEditingController_decription.text;
                              var dio = Dio();
                              var url =
                                  "http://1.117.72.161:8083/schoollink/feed";
                              try {
                                var response = await dio.put(url, data: {
                                  'title': title,
                                  'content': text,
                                  'imageCode': '1'
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



