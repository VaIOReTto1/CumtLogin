import 'package:cumt_login/config/toast.dart';

import '../../Login/login_util/prefs.dart';
import '../../config/config.dart';
import '../../config/icon.dart';
import 'entry.dart';
import 'input.dart';
import 'prefs.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';


class Shortcut extends StatefulWidget {
  const Shortcut({Key? key}) : super(key: key);

  @override
  State<Shortcut> createState() => _ShortcutState();
}

class _ShortcutState extends State<Shortcut> {
  List<Map<String, String>> links = [];

  @override
  void initState() {
    super.initState();
    firstLoad();
  }

  void firstLoad() async {
    // 先读取数据
    links = await readLinks();
    setState(() {});
    // 没有数据就传入默认网址
    if(links.isEmpty) {
      links.addAll(Prefs.url);
      // 保存
      saveLinks(links);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildShorcutBox(
        context: context,
        child: Column(
          children: [
            // 标题
            Container(
                padding: EdgeInsets.all(UIConfig.paddingAll),
                child: Row(
                  children: [
                    const Icon(MyIcons.rectangle,size: 30,color: Color.fromRGBO(59, 114, 217, 1),),
                    Text("快捷入口",style: TextStyle(fontSize: UIConfig.fontSizeSubTitle),),
                  ],
                )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Wrap(
                      spacing: 10,
                      children: [
                        // 遍历List创建快捷方式
                        for(int i = 0; i < links.length; i++)
                          _buildEntry(context, links, i),
                        // 添加新的快捷方式
                        _buildAddButton(context),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }


  // 定义整个快捷方式板块的UI
  Widget _buildShorcutBox({
    required BuildContext context,
    required Widget child
  }) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      width: double.infinity,
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(UIConfig.borderRadiusBox),
      //     border: Border.all(
      //         color: Theme.of(context).colorScheme.primary,
      //         width: 2.0
      //     )
      // ),
      child: child,
    );
  }

  // 定义每个快捷选项的UI
  Widget _buildEntry(
      BuildContext context,
      List<Map<String, String>> links,
      int index
      ) {
    return Entry(
      callback: () {
        setState(() {});
      },
      web: links[index],
      links: links,
      index: index,
      child: InkWell(
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: links[index]["url"]!));
          showToast("已复制到剪切板");
        },
        onTap: () { _openUrl(links[index]["url"]); },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: UIConfig.marginVertical),
          padding: EdgeInsets.all(UIConfig.paddingAll),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).canvasColor,
          ),
          child: Wrap(
            spacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              if (links[index]["name"] != null) Text(links[index]["name"]!, style: const TextStyle(fontSize: 15))
            ],
          ),
        ),
      ),
    );
  }

  // 添加按钮
  Widget _buildAddButton(BuildContext context) {
    return InkWell(
      onTap: () {
        toDialog(
            context: context,
            list: links,
            // 把setState作为回调传入
            // 调用时机在点击添加按钮，add进links之后
            callback: () { setState(() {}); }
        );

      },
      child: Container(
        width: 75,
        margin: EdgeInsets.symmetric(vertical: UIConfig.marginVertical),
        padding: EdgeInsets.all(UIConfig.paddingAll),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).canvasColor,
        ),
        child: const Wrap(
          spacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            Icon(Icons.add)
          ],
        ),
      ),
    );
  }
}

// TODO 多次调用，要讨论统一实现方式
void _openUrl(String? url) {
  launchUrl(
    Uri.parse(url!),
    mode: LaunchMode.externalApplication,
  );
}
