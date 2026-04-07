import 'package:bt_bili/core/bt_state.dart';
import 'package:bt_bili/http/core/bt_error.dart';
import 'package:bt_bili/http/dao/home_dao.dart';
import 'package:bt_bili/models/banner_model.dart';
import 'package:bt_bili/models/home_mo.dart';
import 'package:bt_bili/models/video_model.dart';
import 'package:bt_bili/util/toast.dart';
import 'package:bt_bili/widget/home/bt_banner.dart';
import 'package:bt_bili/widget/home/video_card.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPage extends StatefulWidget {
  final String category;

  const HomeTabPage({super.key, required this.category});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends BtState<HomeTabPage> {
  List<BannerModel>? bannerList;
  List<VideoModel>? videoList;

  int currentIndex = 1;
  bool hasMore = true;

  final EasyRefreshController _controller = EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );

  late ScrollController scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    loadData(isRefresh: true);
  }

  @override
  void dispose() {
    scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: EasyRefresh(
        controller: _controller,
        scrollController: scrollController,
        header: MaterialHeader(),
        footer: const ClassicFooter(),
        onRefresh: () async {
          //
          currentIndex = 1;
          await loadData(isRefresh: true);
        },
        onLoad: () async {
          if (!hasMore) return;
          currentIndex++;
          await loadData();
        },
        child: _listView(),
      ),
    );
  }

  BtBanner _banner() {
    return BtBanner(
      bannerList: bannerList ?? [],
      padding: EdgeInsets.only(left: 5, right: 5),
    );
  }

  Future<void> loadData({bool isRefresh = false}) async {
    try {
      HomeMo result = await HomeDao.get(
        widget.category,
        pageIndex: currentIndex,
        pageSize: 10,
      );
      setState(() {
        if (isRefresh) {
          videoList = result.videoList ?? [];
          bannerList = result.bannerList ?? [];
        } else {
          if ((result.videoList?.length ?? 0) > 0) {
            videoList?.addAll(result.videoList ?? []);
            hasMore = true;
          } else {
            hasMore = false;
          }
        }
        if (isRefresh) {
          _controller.finishRefresh();
          _controller.resetFooter();
        } else {
          _controller.finishLoad(
            hasMore ? IndicatorResult.success : IndicatorResult.noMore,
          );
        }
      });
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on BtNetError catch (e) {
      showWarnToast(e.message);
    }
  }

  SingleChildScrollView _listView() {
    return SingleChildScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        axisDirection: AxisDirection.down,
        children: [
          if ((bannerList ?? []).length > 0)
            StaggeredGridTile.fit(crossAxisCellCount: 2, child: _banner()),
          ...?videoList?.map((videoModel) {
            return StaggeredGridTile.fit(
              crossAxisCellCount: 1,
              child: VideoCard(videoModel: videoModel),
            );
          }),
        ],
      ),
    );
  }
}
