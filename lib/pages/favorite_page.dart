import 'package:bt_bili/http/dao/favorite_list_dao.dart';
import 'package:bt_bili/http/core/bt_error.dart';
import 'package:bt_bili/models/ranking_model.dart';
import 'package:bt_bili/models/video_model.dart';
import 'package:bt_bili/util/toast.dart';
import 'package:bt_bili/widget/loading_container.dart';
import 'package:bt_bili/widget/video_large_card.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with AutomaticKeepAliveClientMixin {
  List<VideoModel> videoList = [];
  bool _isLoading = true;
  int currentIndex = 1;
  bool hasMore = true;

  final EasyRefreshController _easyRefreshController = EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    loadData(isRefresh: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _easyRefreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: Text("收藏", style: TextStyle(fontSize: 16))),
      body: LoadingContainer(
        isLoading: _isLoading,
        child: EasyRefresh(
          controller: _easyRefreshController,
          scrollController: _scrollController,
          header: const MaterialHeader(),
          footer: const ClassicFooter(),
          onRefresh: () async {
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> loadData({bool isRefresh = false}) async {
    try {
      RankingModel result = await FavoriteListDao.get(pageIndex: currentIndex);
      setState(() {
        if (isRefresh) {
          videoList = result.list ?? [];
          hasMore = true;
          _isLoading = false;
        } else {
          if ((result.list?.length ?? 0) > 0) {
            videoList.addAll(result.list ?? []);
            hasMore = true;
          } else {
            hasMore = false;
          }
        }
        if (isRefresh) {
          _easyRefreshController.finishRefresh();
          _easyRefreshController.resetFooter();
        } else {
          _easyRefreshController.finishLoad(
            hasMore ? IndicatorResult.success : IndicatorResult.noMore,
          );
        }
      });
    } on NeedAuth catch (e) {
      setState(() {
        _isLoading = false;
      });
      showWarnToast(e.message);
    } on NeedLogin catch (e) {
      setState(() {
        _isLoading = false;
      });
      showWarnToast(e.message);
    }
  }

  Widget _listView() {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 0),
      itemCount: videoList.length,
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) =>
          VideoLargeCard(videoModel: videoList[index]),
    );
  }
}
