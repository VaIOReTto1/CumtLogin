import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import '../config.dart';

class Shortcut extends StatelessWidget {
  const Shortcut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(UIConfig.marginAll),
      padding: EdgeInsets.all(UIConfig.paddingAll),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(UIConfig.borderRadiusBox),
        border: Border.all(
            color: Theme.of(context).colorScheme.primary == Colors.blue
            ? const Color.fromRGBO(230, 231, 233, 1)
            : Theme.of(context).colorScheme.primary
        )
      ),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(UIConfig.paddingAll),
              child: Text("快捷入口",style: TextStyle(fontSize: UIConfig.fontSizeSubTitle),)
          ),
          Wrap(
            spacing: 10,
            children: [
              _buildEntry(context, "中国矿业大学", "https://www.cumt.edu.cn"),
              _buildEntry(context, "百度", "https://www.baidu.com"),
              _buildAddButton()
            ],
          )
        ],
      ),
    );
  }

  Widget _buildEntry(BuildContext context, String name, String url) {
    return InkWell(
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: url));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("已复制到剪切板"))
        );
      },
      onTap: () { launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication); },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: UIConfig.marginVertical),
        padding: EdgeInsets.all(UIConfig.paddingAll),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UIConfig.borderRadiusEntry),
            color: Theme.of(context).colorScheme.primary == Colors.blue
                ? const Color.fromRGBO(230, 231, 233, 1)
                : Theme.of(context).colorScheme.primary
        ),
        child: Wrap(
          spacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            const Icon(Icons.link,),
            Text(name, style: TextStyle(fontSize: UIConfig.fontSizeMid))
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return InkWell(
      onTap: () { print("Add new entry!");},
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
