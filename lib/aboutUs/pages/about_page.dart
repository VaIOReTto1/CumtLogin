import 'package:cumt_login/config.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/services.dart';
import '../cpns/dividing_cpn.dart';
import '../cpns/project_group.dart';
import '../cpns/res_group_tile.dart';
import '../cpns/single_info_card.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).cardColor
          : Colors.grey.shade300,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            centerTitle: false,
            pinned: true,
            floating: false,
            snap: false,
            primary: true,
            expandedHeight: 200.0,
            elevation: 0,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Theme.of(context).cardColor
                : Colors.grey.shade300,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: UIConfig.fontSizeSubTitle * 2,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : loginColorGreen1,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.pin,
              background: SizedBox(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: UIConfig.fontSizeMid * 6,
                  ),
                  Image(
                    image: const AssetImage('images/logo.png'),
                    height: UIConfig.fontSizeMid * 12,
                    width: UIConfig.fontSizeMid * 12,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: UIConfig.fontSizeMid * 1.5,
                  ),
                  Text(
                    '校园网自动登录',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // color: Theme.of(context).primaryColor,
                        fontSize: UIConfig.fontSizeSubMain * 1.2,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3),
                  ),
                  SizedBox(
                    height: UIConfig.fontSizeSubMain * 0.8,
                  ),
                  Text(
                    '— 自动登录行校园 —',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // color: Theme.of(context).primaryColor,
                        fontSize: UIConfig.fontSizeSubMain * 1.2,
                        letterSpacing: 3),
                  ),
                ],
              )),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: UIConfig.fontSizeMin * 2),
            sliver: SliverToBoxAdapter(
              child: _buildHeaderInfo(), //将原来的ListView中的children放在这里
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const DividingCpn(
          text: '项目组',
        ),
        const ProjectGroup(),
        const DividingCpn(
          text: '反馈群',
        ),
        SizedBox(
          height: UIConfig.fontSizeSubMain * 1.8,
        ),
        ResGroupTile(
          context: context,
          qNumber: '839372371',
          text: '交流1群',
        ),
        SizedBox(
          height: UIConfig.fontSizeSubMain * 1.8,
        ),
        ResGroupTile(
          context: context,
          qNumber: '957634136',
          text: '交流2群',
        ),
      ],
    );
  }
}
