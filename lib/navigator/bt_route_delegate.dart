import 'package:bt_bili/navigator/bt_navigator.dart';
import 'package:bt_bili/navigator/bt_routes.dart';
import 'package:bt_bili/pages/home_page.dart';
import 'package:bt_bili/pages/login_page.dart';
import 'package:bt_bili/pages/register_page.dart';
import 'package:flutter/material.dart';

class BtRouteDelegate extends RouterDelegate<BtRouteDelegate>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BtRouteDelegate> {
  BtRouteDelegate? path;
  List<MaterialPage> pages = [];

  bool get hasLogin => false;

  RouterStatus _routerStatus = RouterStatus.home;

  RouterStatus get routerStatus {
    //登陆鉴权
    if (_routerStatus != RouterStatus.register && !hasLogin) {
      return _routerStatus = RouterStatus.login;
    } else {
      return _routerStatus;
    }
  }

  @override
  // TODO: implement navigatorKey
  final GlobalKey<NavigatorState>? navigatorKey;

  BtRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    BtNavigator.getInstance().registerRouteJump(
      RouteJumpListener(
        onJumpTo: (RouterStatus routerStatus, {Map? args}) {
          _routerStatus = routerStatus;
          notifyListeners();
        },
      ),
    );
  }

  //根据RouterStatus获取page
  MaterialPage getPage(RouterStatus routerStatus) {
    var page;
    if (routerStatus == RouterStatus.home) {
      pages.clear();
      page = HomePage();
    } else if (routerStatus == RouterStatus.login) {
      page = LoginPage();
    } else if (routerStatus == RouterStatus.register) {
      page = RegisterPage();
    }
    return pageWrap(page);
  }

  //管理栈区
  void managerStack() {
    //获取当前页面状态的index位置
    var index = getPageIndex(pages, routerStatus);

    //截取栈区
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      tempPages = tempPages.sublist(0, index);
    }
    var page = getPage(routerStatus);
    tempPages = [...tempPages, page];
    BtNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages;
  }

  @override
  Widget build(BuildContext context) {
    managerStack();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {},
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onDidRemovePage: (Page<Object?> page) {
          var tempPages = [...pages];
          if (pages.contains(page)) {
            pages.remove(page);
          }
          BtNavigator.getInstance().notify(pages, tempPages);
          if (pages.isNotEmpty) {
            var currentPage = pages.last;
            _routerStatus = getStatus(currentPage);
          }
        },
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(BtRouteDelegate configuration) async {
    path = configuration;
  }
}

class BtRoutePath {}
