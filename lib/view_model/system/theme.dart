/*
 * @Author: zhang（修改版 by ChatGPT）
 * @Description: 兼容 Flutter 2.10.5 + 桌面端 + AnimationController
 */

import 'package:flutter/material.dart';
import 'package:welterstock/utils/sp_util.dart';

class ThemeModel extends State<StatefulWidget>
    with ChangeNotifier, TickerProviderStateMixin {
  static const TLThemeUserDarkMode = 'TLThemeUserDarkMode';

  bool userDarkMode;
  MaterialColor _themeColor;
  Color filterColor;

  AnimationController animController;
  Animation<Color> animation;

  ThemeModel() {
    // 初始化基本变量（这里不创建 AnimationController）
    userDarkMode = SpUtil.instance.getBool(TLThemeUserDarkMode) ?? false;
    filterColor = userDarkMode ? Colors.grey[600] : Colors.white;
    _themeColor = Colors.primaries[15];
  }

  /// 初始化动画控制器
  /// 注意：必须在组件挂载后（mounted == true）再创建 AnimationController
  void initAnimationController() {
    if (mounted && animController == null) {
      animController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1500),
      );

      animation =
      ColorTween(begin: Colors.white, end: Colors.grey[600]).animate(animController)
        ..addListener(() {
          if (mounted) {
            filterColor = animation.value;
            notifyListeners();
          }
        });
    }
  }

  /// 切换主题（动画与状态同步）
  void switchTheme({bool serDarkMode, MaterialColor color}) {
    // 确保动画控制器已初始化
    initAnimationController();

    userDarkMode = !userDarkMode;

    if (userDarkMode == false) {
      animController.forward();
    } else {
      animController.reverse();
    }

    SpUtil.instance.putBool(TLThemeUserDarkMode, userDarkMode);
  }

  /// 构建主题数据
  ThemeData themeData({bool platformDarkMode = false}) {
    var isDark = platformDarkMode || userDarkMode;
    var themeColor = _themeColor;
    var accentColor = isDark
        ? themeColor.withOpacity(1)
        : _themeColor.withOpacity(1);

    var themeData = ThemeData(
      primarySwatch: themeColor,
      accentColor: accentColor,
      brightness: Brightness.light,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      fontFamily: 'Montserrat',
    );

    themeData = themeData.copyWith(
      scaffoldBackgroundColor: Color.fromRGBO(255, 255, 255, 1),
    );

    return themeData;
  }

  @override
  void initState() {
    super.initState();
    // 在组件 mount 后安全初始化动画控制器
    initAnimationController();
  }

  @override
  void dispose() {
    // 在销毁时正确释放动画控制器
    if (animController != null) {
      animController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // 此处不渲染任何内容
  }
}
