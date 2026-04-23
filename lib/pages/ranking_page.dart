import 'package:bt_bili/pages/rank_tab_page.dart';
import 'package:bt_bili/widget/bt_tab.dart';
import 'package:bt_bili/widget/home/bt_navigation_bar_plus.dart';
import 'package:flutter/material.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage>
    with TickerProviderStateMixin {
  static const Tabs = [
    {'key': 'like', 'name': '最热'},
    {'key': 'pubdate', 'name': '最新'},
    {'key': 'favorite', 'name': '收藏'},
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: Tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [_buildNavigationBar(), _buildTabView()]),
    );
  }

  BtNavigationBarPlus _buildNavigationBar() {
    return BtNavigationBarPlus(
      color: Colors.white,
      height: 50,
      child: _tabbar(),
    );
  }

  _tabbar() {
    return BtTab(
      tabs: Tabs.map((tab) {
        return Tab(text: tab['name']);
      }).toList(),
      controller: _tabController,
    );
  }

  _buildTabView() {
    return Flexible(
      child: TabBarView(
        controller: _tabController,
        children: [
          ...Tabs.map((tab) {
            return RankTabPage(sort: tab['key'] ?? '');
          }),
        ],
      ),
    );
  }
}
