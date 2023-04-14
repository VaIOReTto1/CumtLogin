import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import '../config.dart';

class Shortcut extends StatefulWidget {
  const Shortcut({Key? key}) : super(key: key);

  @override
  State<Shortcut> createState() => _ShortcutState();
}

class _ShortcutState extends State<Shortcut> {
  List<Map<String, String>> links = [
    {"name" : "中国矿业大学", "url" : "https://www.cumt.edu.cn"},
    {"name" : "必应", "url":"https://bing.com"},
    {"name" : "物理实验中心", "url" : "http://10.103.4.10:8020/"},
    {"name" : "教务选课", "url" : "http://127.0.0.1:8000"},
    {"name" : "中国矿业大学馆藏数字化平台", "url" : "http://121.248.104.172:8080/"},
  ];

  @override
  Widget build(BuildContext context) {
    print("build");
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
                  _buildEntry(context, links[i]),
                // 添加新的快捷方式
                //_buildAddButton(context),
              ],
            )
          ],
        )
    );
  }

  void _openUrl(String? url) {
    launchUrl(
        Uri.parse(url!),
        mode: LaunchMode.externalApplication
    );
  }

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
              color: Theme.of(context).colorScheme.primary == Colors.blue
                  ? const Color.fromRGBO(230, 231, 233, 1)
                  : Theme.of(context).colorScheme.primary,
              width: 2.0
          )
      ),
      child: child,
    );
  }

  Widget _buildEntry(BuildContext context, Map<String?, String?> web) {
    return InkWell(
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: web["url"]));
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("已复制到剪切板"))
        );
      },
      onTap: () { _openUrl(web["url"]); },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: UIConfig.marginVertical),
        padding: EdgeInsets.all(UIConfig.paddingAll),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UIConfig.borderRadiusEntry),
            color: Theme.of(context).colorScheme.primary == Colors.blue
                ? const Color.fromRGBO(230, 231, 233, 1)
                : Colors.black38
        ),
        child: Wrap(
          spacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            const Icon(Icons.link,),
            Text(web["name"]!, style: TextStyle(fontSize: UIConfig.fontSizeMid))
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: UIConfig.marginVertical),
        padding: EdgeInsets.all(UIConfig.paddingAll),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UIConfig.borderRadiusEntry),
            color: Colors.grey[200]
        ),
        child: Wrap(
          children: const [Icon(Icons.add)],
        ),
      ),
    );
  }
}