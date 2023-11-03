import 'package:cumt_login/config/config.dart';
import 'package:cumt_login/settings/drawer_button.dart';
import 'package:cumt_login/config/toast.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../../config/icon.dart';
import '../../config/theme_color.dart';
import 'LoginBox.dart';
import '../login_util/account.dart';
import '../login_util/login.dart';
import '../login_util/prefs.dart';

toLoginPage(BuildContext context) {
  Navigator.of(context).pushReplacement(CupertinoPageRoute(
    builder: (context) => const LoginPage(),
    fullscreenDialog: true, // 路由为全屏模式
  ));
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  CumtLoginAccount cumtLoginAccount = CumtLoginAccount();
  double keyboardHeight = 0.0; //键盘打开情况

  //日活统计
  Future<void> logLoginEvent() async {
    await analytics.logEvent(
      name: 'daily user count',
    );
  }

  @override
  void initState() {
    super.initState();
    ThemeProvider;
    logLoginEvent();
    WidgetsBinding.instance.addObserver(this);
    _usernameController.text = cumtLoginAccount.username!;
    _passwordController.text = cumtLoginAccount.password!;
    if (_usernameController.text.isNotEmpty) {
      _handleLogin(context);
    }

    //登录页圆圈动画
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.7, end: 0.8).animate(_controller);
  }

  //监听键盘打开情况
  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    setState(() {
      keyboardHeight = bottomInset;
    });
  }

  //自动登录
  void _handleLogin(BuildContext context) {
    if (_usernameController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      showToast('账号或密码不能为空');
      return;
    }
    cumtLoginAccount.username = _usernameController.text.trim();
    cumtLoginAccount.password = _passwordController.text.trim();

    CumtLogin.login(account: cumtLoginAccount).then((value) {
      setState(() {
        showToast(value);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        // 当用户向上滑动时，跳出登陆栏
        if (details.primaryDelta! < -5) {
          _loginpage();
        }
      },
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  //登录页上部分
                  LoginAppBar(context),
                ],
              ),
              LoginLabel(context),
              //登录页中间部分（圆圈动画
              LoginCircleAnimation(context),
              //登录栏
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.02,
                child: InkWell(
                  onTap: () {
                    _loginpage();
                  },
                  child: const Icon(Icons.keyboard_arrow_up_rounded,
                      color: Color.fromRGBO(59, 114, 217, 1),
                      size: 40,
                      shadows: <Shadow>[
                        Shadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius: 10.0,
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget LoginCircleAnimation(BuildContext context) {
    return Stack(
      children: [
        Elippse(rotation: 0.00,),
        Elippse(rotation: 60.0,),
        Elippse(rotation: 120.0),
        //周围圆环动画
        Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget? child) {
              final color = Prefs.status == '1'
                  ? Color.fromRGBO(66, 128, 237, 0.4 - (_animation.value / 10))
                  : Color.fromRGBO(234, 234, 234, 1 - (_animation.value / 10));

              return Container(
                width: MediaQuery.of(context).size.height *
                    0.29 *
                    _animation.value,
                height: MediaQuery.of(context).size.height *
                    0.29 *
                    _animation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color,
                      spreadRadius: 10 * _animation.value,
                      blurRadius: 30 * _animation.value,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        //中间圆圈
        Center(
          child: InkWell(
            onTap: () => _handleLogin(context),
            highlightColor: Colors.transparent,
            radius: 0,
            child: Container(
              width: MediaQuery.of(context).size.height * 0.2,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Prefs.status == '1'
                    ? const Color.fromRGBO(59, 114, 217, 1)
                    : const Color.fromRGBO(161, 161, 161, 1),
              ),
              child: Icon(
                MyIcons.link,
                size: MediaQuery.of(context).size.height * 0.096,
                color: const Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget LoginLabel(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).size.height * 0.19,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromRGBO(246, 246, 246, 1),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 3, 15, 3),
            child: Row(
              children: [
                const Icon(
                  Icons.circle_sharp,
                  color: Color.fromRGBO(59, 114, 217, 1),
                  size: 7,
                ),
                const SizedBox(
                  width: 15,
                ),
                Prefs.status == '1'
                    ? const Text(
                        '已连接    ',
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                      )
                    : const Text(
                        '未连接    ',
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                      ),
              ],
            ),
          ),
        ));
  }

  Widget LoginAppBar(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.119,
      padding: EdgeInsets.fromLTRB(18, MediaQuery.of(context).padding.top, 18, 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness != Brightness.dark
                ? const Color.fromRGBO(59, 114, 217, 0.2)
                : Colors.black38,
            spreadRadius: 12,
            blurRadius: 18,
            offset: Offset.zero, // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(child: Container()),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  '${Prefs.school1}',
                  style: TextStyle(
                    fontSize: UIConfig.fontSizeTitle * 1.2,
                    color: const Color.fromRGBO(59, 114, 217, 1),
                  ),
                ),
              ),
              HelpButton(),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0105,
          )
        ],
      ),
    );
  }

  void _loginpage() {
    //底部跳出边框
    showModalBottomSheet(
        isScrollControlled: true,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        context: context,
        builder: (context) {
          return SizedBox(
            height: keyboardHeight != 0.0
                ? MediaQuery.of(context).size.height * 0.7 // 当键盘可见时，增加高度
                : MediaQuery.of(context).size.height * 0.39,
            child: const LoginBox(),
          );
        });
  }
}

class Elippse extends StatefulWidget {
  double rotation;
  Elippse({super.key,required this.rotation});


  @override
  State<Elippse> createState() => _ElippseState();
}

class _ElippseState extends State<Elippse> with SingleTickerProviderStateMixin {
  late double padding=widget.rotation;
  @override
  void initState() {
    super.initState();
    // 启动一个循环动画
    startRotationAnimation();
  }


  void startRotationAnimation() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        widget.rotation=widget.rotation + 5; // 控制旋转速度，可以根据需要调整
        startRotationAnimation();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, padding/8, 0, padding/2),
        child: Transform.rotate(
          angle: widget.rotation* 3.14 / 180.0, // 旋转角度
          child: CustomPaint(
            size: Size(MediaQuery.of(context).size.height * 0.7,
                MediaQuery.of(context).size.height * 0.55),
            painter: EllipsePainter(),
          ),
        ),
      ),
    );
  }
}

class EllipsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Prefs.status == '1'?Colors.blue.withOpacity(0.4):Colors.grey.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radiusX = size.width / 2;
    double radiusY = size.height / 2;

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: radiusX,
        height: radiusY,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}