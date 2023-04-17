import 'package:cumt_login/shortcut/entry.dart';
import 'package:cumt_login/shortcut/input.dart';
import 'package:cumt_login/shortcut/prefs.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import '../config.dart';
import '../utils/utils.dart';


class Shortcut extends StatefulWidget {
  const Shortcut({Key? key}) : super(key: key);

  @override
  State<Shortcut> createState() => _ShortcutState();
}

class _ShortcutState extends State<Shortcut> {
  List<Map<String, String>> links = [];
  // 默认网址
  List<Map<String, String>> defaultLinks = [
    {"name" : "中国矿业大学", "url" : "https://www.cumt.edu.cn"},
    {"name" : "物理实验中心", "url" : "http://10.103.4.10:8020/"},
    {"name" : "教务选课", "url" : "http://127.0.0.1:8000"},
    {"name" : "中国矿业大学馆藏数字化平台", "url" : "http://121.248.104.172:8080/"},
  ];

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
      links.addAll(defaultLinks);
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
                child: Text("快捷入口",style: TextStyle(fontSize: UIConfig.fontSizeSubTitle),)
            ),
            Wrap(
              spacing: 10,
              children: [
                // 遍历List创建快捷方式
                for(int i = 0; i < links.length; i++)
                  _buildEntry(context, links, i),
                // 添加新的快捷方式
                _buildAddButton(context),
              ],
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
      margin: EdgeInsets.all(UIConfig.marginAll),
      padding: EdgeInsets.all(UIConfig.paddingAll),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(UIConfig.borderRadiusBox),
          border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 2.0
          )
      ),
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
          Clipboard.setData(ClipboardData(text: links[index]["url"]));
          showSnackBar(context, "已复制到剪切板");
        },
        onTap: () { _openUrl(links[index]["url"]); },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: UIConfig.marginVertical),
          padding: EdgeInsets.all(UIConfig.paddingAll),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UIConfig.borderRadiusEntry),
              color: Theme.of(context).colorScheme.primary
          ),
          child: Wrap(
            spacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              const Icon(Icons.link,),
              Text(links[index]["name"]!, style: TextStyle(fontSize: UIConfig.fontSizeMid))
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
        margin: EdgeInsets.symmetric(vertical: UIConfig.marginVertical),
        padding: EdgeInsets.all(UIConfig.paddingAll),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UIConfig.borderRadiusEntry),
            color: Theme.of(context).colorScheme.primary
        ),
        child: Wrap(
          children: const [Icon(Icons.add)],
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
