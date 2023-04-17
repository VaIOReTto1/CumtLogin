import 'package:cumt_login/shortcut/prefs.dart';
import 'package:cumt_login/utils/utils.dart';
import 'package:flutter/material.dart';
import 'edit.dart';

// 定义每个entry的滑动操作
class Entry extends StatelessWidget {
  final Widget child;
  final Map<String?, String?> web;
  final List<Map<String, String>> links;
  final VoidCallback callback;
  final int index;

  const Entry({
    Key? key,
    required this.child,
    required this.web,
    required this.links,
    required this.callback,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (DismissDirection direction) {
        if(direction == DismissDirection.startToEnd) {
          links.remove(web);
          saveLinks(links);
          showSnackBar(context, "已删除 ${web["name"]}");
        }
      },
      // 向左滑编辑时，不清除entry,将播放逆向返回动画
      confirmDismiss: (DismissDirection direction) async {
        if(direction == DismissDirection.endToStart) {
          // TODO:在此处弹出编辑菜单
          toEditing(
              context: context,
              list: links,
              index: index,
              callback: callback,
              initName: web["name"],
              initUrl: web["url"],
          );
          return false;
        } else {
          return true;
        }
      },
      // 向右滑删除
      background: Container(
        alignment: Alignment.centerLeft,
        child: const Icon(Icons.delete),
      ),
      // 向左滑编辑
      secondaryBackground:  Container(
        alignment: Alignment.centerRight,
        child: const Icon(Icons.edit),
      ),
      child: child,
    );
  }
}

