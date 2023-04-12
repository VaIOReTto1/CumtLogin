import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

import '../../config.dart';

class ResGroupTile extends StatelessWidget {
  const ResGroupTile({
    super.key,
    required this.context,
    required this.qNumber,
    required this.text,
  });

  final String qNumber;
  final String text;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: qNumber)).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('已复制到剪贴板')),
          );
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).brightness == Brightness.dark
                ? Theme.of(context).cardColor
                : Colors.grey.shade300,
            boxShadow: [
              BoxShadow(
                offset: Offset(8, 8),
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color(0xFF383837).withAlpha(255)
                    : Colors.black38,
                blurRadius: 15,
              ),
              BoxShadow(
                offset: const Offset(-8, -8),
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color(0xFF4c4c4b).withAlpha(255)
                    : Colors.white70,
                blurRadius: 15,
              )
            ]),
        width: MediaQuery.of(context).size.width * .86,
        child: GFListTile(
            avatar: SizedBox(
              child: GFAvatar(
                size: UIConfig.borderRadiusBox * 1.2,
                backgroundImage:
                NetworkImage("http://p.qlogo.cn/gh/$qNumber/$qNumber/640/"),
              ),
            ),
            title: Text(
              text,
              style: TextStyle(
                  fontSize: UIConfig.fontSizeMain * 1.5,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black),
            ),
            subTitle: Padding(
              padding:  EdgeInsets.only(top: UIConfig.paddingVertical),
              child: Text(
                '点击复制群号',
                style: TextStyle(
                    fontSize: UIConfig.fontSizeMin * 1.4,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black54),
              ),
            )),
      ),
    );
  }
}