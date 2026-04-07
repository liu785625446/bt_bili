import 'package:bt_bili/core/bt_state.dart';
import 'package:bt_bili/http/core/bt_error.dart';
import 'package:bt_bili/http/dao/home_dao.dart';
import 'package:bt_bili/models/banner_model.dart';
import 'package:bt_bili/models/home_mo.dart';
import 'package:bt_bili/models/video_model.dart';
import 'package:bt_bili/navigator/bt_navigator.dart';
import 'package:bt_bili/pages/home_tab_page.dart';
import 'package:bt_bili/util/color.dart';
import 'package:bt_bili/util/toast.dart';
import 'package:bt_bili/util/view_util.dart';
import 'package:bt_bili/widget/home/bt_navigation_bar_plus.dart';
import 'package:bt_bili/widget/loading_container.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BtState<HomePage> with TickerProviderStateMixin {
  var listener;

  TabController? _tabController;
  List<CategoryModel> categoryList = [];
  List<BannerModel> bannerList = [];
  List<VideoModel> videoList = [];
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listener = BtNavigator.getInstance().registerStatePage(
      widget,
      onResue: () {
        print("首页打开");
      },
      onPause: () {
        print("首页关闭");
      },
    );

    _tabController = TabController(length: categoryList.length, vsync: this);
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    BtNavigator.getInstance().removeListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        isLoading: _isLoading,
        child: Column(
          children: [
            BtNavigationBarPlus(
              color: Colors.white,
              height: 50,
              child: _appBar(),
            ),
            Container(padding: EdgeInsets.only(top: 8), child: _topTabBar()),
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: categoryList.map((tab) {
                  return HomeTabPage(category: tab.name ?? "");
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget? _topTabBar() {
    return TabBar(
      controller: _tabController,
      labelStyle: TextStyle(fontSize: 15),
      labelColor: primary,
      isScrollable: true,
      tabs: categoryList.map<Tab>((tab) {
        return Tab(text: tab.name);
      }).toList(),
    );
  }

  void loadData() async {
    try {
      HomeMo result = await HomeDao.get("推荐");
      if (result.categoryList != null) {
        _tabController = TabController(
          length: result.categoryList?.length ?? 0,
          vsync: this,
        );
      }
      setState(() {
        categoryList = result.categoryList ?? [];
        bannerList = result.bannerList ?? [];
        videoList = result.videoList ?? [];
        _isLoading = false;
      });
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
      setState(() {
        _isLoading = false;
      });
    } on BtNetError catch (e) {
      showWarnToast(e.message);
      setState(() {
        _isLoading = false;
      });
    }
  }

  _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Image(
                height: 46,
                width: 46,
                image: AssetImage("images/avatar.png"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 32,
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.search, color: Colors.grey),
                  decoration: BoxDecoration(color: Colors.grey[100]),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              // _mockCrash(context);
            },
            child: Icon(Icons.explore_outlined, color: Colors.grey),
          ),
          hiSpace(width: 12),
          InkWell(
            onTap: () {},
            child: Icon(Icons.mail_outline, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
