import 'package:cumt_login/drawer/drawer_button.dart';
import 'package:flutter/material.dart';
import '../config.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary == Colors.blue
            ? const Color.fromRGBO(230, 231, 233, 1)
            : Colors.grey.shade700,
        child: Column(
          children: [
            Container(
              height: 250,
              color: const Color.fromRGBO(230, 231, 233, 1), // 设置Container的颜色
              child: const UserAccountsDrawerHeader(
                accountName: null,
                accountEmail: null,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    scale: 1.5,
                    image: AssetImage('images/logo_modify.png'),
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(UIConfig.paddingAll),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color:
                            Theme.of(context).colorScheme.primary == Colors.blue
                                ? Colors.grey.shade300
                                : Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(8, 8),
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color(0xFF383837).withAlpha(255)
                                    : Colors.black38,
                            blurRadius: 15,
                          ),
                          BoxShadow(
                            offset: const Offset(-8, -8),
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color(0xFF4c4c4b).withAlpha(255)
                                    : Colors.white70,
                            blurRadius: 15,
                          )
                        ]),
                    width: MediaQuery.of(context).size.width * .86,
                    child: SingleChildScrollView(
                      child: Column(
                        children: const [
                          DrawerButton(),
                          ImageSelectButton(),
                          ImageDeleteButton(),
                          LightThemeButton(),
                          DarkThemeButton(),
                          UpdatecheckButton(),
                          FeedBackButton(),
                        ],
                      ),
                    ))),
          ],
        ));
  }
}
