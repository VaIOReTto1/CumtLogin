import 'package:flutter_screenutil/flutter_screenutil.dart';

class UIConfig {
  // 屏幕大小
  static const double designWidth = 1440;
  static const double designHeight = 3120;

  // 字体大小
  static final double fontSizeTitle = ScreenUtil().setSp(54); // AppBar标题
  static final double fontSizeSubTitle =
      ScreenUtil().setSp(50); // 关于我们、反馈、检查更新的标题
  static final double fontSizeMain = ScreenUtil().setSp(46); // 主页面按钮 Drawer选项
  static final double fontSizeSubMain =
      ScreenUtil().setSp(42); // 关于我们、反馈、检查更新正文
  static final double fontSizeMid = ScreenUtil().setSp(42); // TextField 快捷入口
  static final double fontSizeMin = ScreenUtil().setSp(40); // 校区&运营商

  // 布局
  static final double marginVertical = ScreenUtil().setHeight(10); // 上下外边距
  static final double marginHorizontal = ScreenUtil().setWidth(15); // 左右外边距
  static final double marginAll = ScreenUtil().setWidth(20); // 所有外边距

  static final double paddingVertical = ScreenUtil().setHeight(12); // 上下内边距
  static final double paddingHorizontal = ScreenUtil().setWidth(17); // 左右内边距
  static final double paddingAll = ScreenUtil().setWidth(20); // 所有内边距

  static const double borderRadiusButton = 18; // 按钮圆角
  static const double borderRadiusEntry = 10; // 快捷入口圆角
  static const double borderRadiusBox = 20; // 大块功能区圆角
}
