import 'package:flutter/material.dart';
import 'main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      toLoginPage(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(230, 231, 233, 1),
      body: Container(
        child: Align(
          alignment: Alignment(0,0),
          child: Image.asset(
            'images/logo1.png',
            width: 248,
            height: 248,
          ),
        ),
      ),
    );
  }
}