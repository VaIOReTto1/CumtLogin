import 'package:flutter/material.dart';

import '../config.dart';

toUrlPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => UrlPage(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class UrlPage extends StatefulWidget {
  UrlPage({Key? key}) : super(key: key);

  @override
  State<UrlPage> createState() => _UrlPageState();
}

class _UrlPageState extends State<UrlPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body:
        CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          SliverAppBar(
            centerTitle: false,
            pinned: true,
            floating: false,
            snap: false,
            primary: true,
            expandedHeight: height * .02,
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: UIConfig.fontSizeMin * 0.1),
            sliver: SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.all(UIConfig.paddingAll),
                  child: Column()//将原来的ListView中的children放在这里
              ),
            ),
          )]));
  }
}