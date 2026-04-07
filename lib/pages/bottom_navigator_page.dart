import 'package:bt_bili/navigator/bt_navigator.dart';
import 'package:bt_bili/pages/favorite_page.dart';
import 'package:bt_bili/pages/home_page.dart';
import 'package:bt_bili/pages/profile_page.dart';
import 'package:bt_bili/pages/ranking_page.dart';
import 'package:flutter/material.dart';

import '../util/color.dart';

class BottomNavigatorPage extends StatefulWidget {
  const BottomNavigatorPage({super.key});

  @override
  State<BottomNavigatorPage> createState() => _BottomNavigatorPageState();
}

class _BottomNavigatorPageState extends State<BottomNavigatorPage> {
  final _defaultColor = Colors.grey;
  final _activeColor = primary;

  final PageController _controller = PageController();
  late List<Widget> _pages;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [HomePage(), RankingPage(), FavoritePage(), ProfilePage()];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onJumpTo,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _activeColor,
        items: [
          _bottomItem("首页", Icons.home, 0),
          _bottomItem("排行", Icons.local_fire_department, 1),
          _bottomItem("收藏", Icons.favorite, 2),
          _bottomItem("我的", Icons.live_tv, 3),
        ],
      ),
    );
  }

  void _onJumpTo(int index) {
    BtNavigator.getInstance().onBottomTabChange(_pages[index]);
    _controller.jumpToPage(index);
    setState(() {
      _currentIndex = index;
    });
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _defaultColor),
      activeIcon: Icon(icon, color: _activeColor),
      label: title,
    );
  }
}
