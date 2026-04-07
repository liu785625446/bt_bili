import 'package:bt_bili/navigator/bt_routes.dart';
import 'package:flutter/material.dart';

// abstract class _RouteJumpListener {
//   void onJumpTo(RouterStatus routeStatus, {Map? args});
// }

//页面跳转监听管理
typedef RouteChangeListener =
    void Function(RouterStatusInfo current, RouterStatusInfo? pre);

//路由跳转管理
typedef OnJumpTo = void Function(RouterStatus routeStatus, {Map? args});

class BtNavigator {
  static BtNavigator? _instance;

  //路由跳转管理
  RouteJumpListener? _routerJumpListener;

  //页面跳转监听管理
  final List<RouteChangeListener> _listeners = [];
  RouterStatusInfo? _current;

  BtNavigator._();

  static BtNavigator getInstance() {
    _instance ??= BtNavigator._();
    return _instance!;
  }

  //监听底部bottomNavigator切换
  void onBottomTabChange(Widget page) {
    RouterStatusInfo statusInfo = RouterStatusInfo(
      routerStatus: RouterStatus.home,
      page: page,
    );
    _notify(statusInfo);
  }

  //页面跳转监听管理
  RouteChangeListener registerStatePage(
    Widget widget, {
    required VoidCallback onResue,
    required VoidCallback onPause,
  }) {
    var listener;
    BtNavigator.getInstance().addListener(
      listener = (RouterStatusInfo current, RouterStatusInfo? pre) {
        print(widget);
        print(current.page);
        if (widget == current.page) {
          onResue();
        } else if (widget == pre?.page) {
          onPause();
        }
      },
    );
    return listener;
  }

  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;

    var current = RouterStatusInfo(
      routerStatus: getStatus(currentPages.last),
      page: currentPages.last.child,
    );
    _notify(current);
  }

  void _notify(RouterStatusInfo current) {
    for (var listener in _listeners) {
      listener(current, _current);
    }
    _current = current;
  }

  //路由跳转管理
  // @override
  void onJumpTo(RouterStatus routeStatus, {Map? args}) {
    _routerJumpListener?.onJumpTo(routeStatus, args: args);
  }

  void registerRouteJump(RouteJumpListener routeJumpListener) {
    _routerJumpListener = routeJumpListener;
  }
}

// 路由跳转管理
class RouteJumpListener {
  final OnJumpTo onJumpTo;

  RouteJumpListener({required this.onJumpTo});
}
