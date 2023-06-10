import 'package:flutter_screenutil/flutter_screenutil.dart';

class UIConfig {
  // 屏幕大小
  static const double designWidth = 1440;
  static const double designHeight = 3120;

  // 字体大小
  static final double fontSizeTitle = ScreenUtil().setSp(58); // AppBar标题
  static final double fontSizeSubTitle =
      ScreenUtil().setSp(54); // 关于我们、反馈、检查更新的标题
  static final double fontSizeMain = ScreenUtil().setSp(50); // 主页面按钮 Drawer选项
  static final double fontSizeSubMain =
      ScreenUtil().setSp(42); // 关于我们、反馈、检查更新正文
  static final double fontSizeMid = ScreenUtil().setSp(42); // TextField 快捷入口
  static final double fontSizeMin = ScreenUtil().setSp(40); // 校区&运营商
  static final double fontAlertText = ScreenUtil().setSp(40); // Drawer中提示字体大小
  static final double fontAlertIcon = ScreenUtil().setSp(40); // Drawer中提示Icon大小
  static final double welcomeSubtitle = ScreenUtil().setSp(70.0); // 欢迎页副标题
  static final double welcomeTitle = ScreenUtil().setSp(150.0); // 欢迎页标题

  // 布局
  static final double marginVertical = ScreenUtil().setHeight(12); // 上下外边距
  static final double marginHorizontal = ScreenUtil().setWidth(17); // 左右外边距
  static final double marginAll = ScreenUtil().setWidth(22); // 所有外边距

  static final double paddingVertical = ScreenUtil().setHeight(14); // 上下内边距
  static final double paddingHorizontal = ScreenUtil().setWidth(19); // 左右内边距
  static final double paddingAll = ScreenUtil().setWidth(22); // 所有内边距

  static const double borderRadiusButton = 18; // 按钮圆角
  static const double borderRadiusEntry = 10; // 快捷入口圆角
  static const double borderRadiusBox = 20; // 大块功能区圆角

}
