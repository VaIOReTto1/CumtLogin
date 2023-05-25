import 'package:cumt_login/UrlPage/shortcut/prefs.dart';
import 'package:flutter/material.dart';

import '../../config.dart';
import '../../icon.dart';
import 'package:flutter/services.dart';

import '../login_util/SchoolDio.dart';
import '../login_util/prefs.dart';
import '../welcome.dart';


class SchoolUrl extends StatefulWidget {
  const SchoolUrl({Key? key}) : super(key: key);

  @override
  State<SchoolUrl> createState() => _SchoolUrlState();
}

class _SchoolUrlState extends State<SchoolUrl> {
  List<Map<String, String>> schoolelection = [];

  @override
  void initState() {
    super.initState();
    firstLoad();
  }

  void firstLoad() async {
    // 先读取数据
    schoolelection = await readschoolelection();
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
                    const Icon(MyIcons.rectangle,size: 17,color: Color.fromRGBO(74, 114, 176, 1),),
                    Text("学校",style: TextStyle(fontSize: UIConfig.fontSizeSubTitle),),
                  ],
                )
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Wrap(
                spacing: 10,
                children: [
                  // 遍历List创建快捷方式
                  for(int i = 0; i < schoolelection.length; i++)
                    _buildEntry(context, schoolelection, i),
                  // 添加新的快捷方式
                  _buildAddButton(context),
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
      color: Colors.white,
      width: double.infinity,
      child: child,
    );
  }

  // 定义每个快捷选项的UI
  Widget _buildEntry(
      BuildContext context,
      List<Map<String, String>> schoolelection,
      int index
      ) {
    return InkWell(
      onTap: () async {
        Prefs.school =  schoolelection[index]['school']!;
        await SchoolDio.SchoolUrlDio(Prefs.school);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: UIConfig.marginVertical),
        padding: EdgeInsets.all(UIConfig.paddingAll),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(UIConfig.borderRadiusEntry),
          color: schoolelection[index]["school"]==Prefs.school?const Color.fromRGBO(245,244,249,1):const Color.fromRGBO(245,244,249,1),
        ),
        child: Wrap(
          spacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            Text(schoolelection[index]["schoolname"]!, style: TextStyle(fontSize: UIConfig.fontSizeMid))
          ],
        ),
      ),
    );
  }

  // 添加按钮
  Widget _buildAddButton(BuildContext context) {
    return InkWell(
      onTap: () {
       toWelComePage(context);
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
