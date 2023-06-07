import 'package:cumt_login/settings/update/toast.dart';

import '../../config.dart';
import 'package:flutter/material.dart';
import '../aboutUs/cpns/single_info_card.dart';
import '../drawer_button.dart';
import 'imagePickButton.dart';

toFeedBackPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const FeedBackPage(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({Key? key}) : super(key: key);

  @override
  State<FeedBackPage> createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  final TextEditingController _textEditingController_title =
      TextEditingController();
  final TextEditingController _textEditingController_decription =
      TextEditingController();
  List<String> _imageList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardTheme.color,
      body: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.119,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(222, 221, 251, 0.5),
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
                              : loginColorGreen1,
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
                    padding: const EdgeInsets.fromLTRB(0, 24.0, 0, 0),
                    child: Container(
                      padding: EdgeInsets.all(UIConfig.paddingAll),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 45,
                            child: TextField(
                              controller: _textEditingController_title,
                              maxLines: 8,
                              minLines: 1,
                              style: TextStyle(color: Colors.grey),
                              decoration: const InputDecoration(
                                hintText: '请输入问题的标题',
                                border: OutlineInputBorder(),
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
                            height: 84,
                            child: TextField(
                              controller: _textEditingController_decription,
                              maxLines: 10,
                              minLines: 1,
                              decoration: const InputDecoration(
                                hintText: '请描述一下你遇到的场景和问题',
                                border: OutlineInputBorder(),
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
                          child: Text(
                            '    图片(提供问题截图，能帮助我们更快定位并解决问题~)',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
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
      ),
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
                  color: Color.fromRGBO(59, 114, 217, 0.9),
                ),
                child: InkWell(
                  onTap: () {
                    showToast('提交成功');
                    Navigator.pop(context);
                  },
                  child: Center(
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
