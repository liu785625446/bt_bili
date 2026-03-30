import 'package:bt_bili/pages/login_page.dart';
import 'package:bt_bili/pages/register_page.dart';
import 'package:flutter/material.dart';

///自定义路由封装，路由状态
enum RouterStatus { home, login, register, detail, unknow }

//创建页面
MaterialPage pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

//通过page获取对应的RouteStatus
RouterStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouterStatus.login;
  } else if (page.child is RegisterPage) {
    return RouterStatus.register;
  } else {
    return RouterStatus.unknow;
  }
}

//获取routerStatus在页面栈中的位置
int getPageIndex(List<MaterialPage> pages, RouterStatus routerStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routerStatus) {
      return i;
    }
  }
  return -1;
}

//page 与key 建立路由映射
class RouterStatusInfo {
  final RouterStatus routerStatus;
  final Widget page;

  RouterStatusInfo({required this.routerStatus, required this.page});
}
