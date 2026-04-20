import 'package:bt_bili/http/core/bt_error.dart';
import 'package:bt_bili/http/dao/video_detail_dao.dart';
import 'package:bt_bili/models/video_detail_mo.dart';
import 'package:bt_bili/models/video_model.dart';
import 'package:bt_bili/util/toast.dart';
import 'package:bt_bili/widget/videoDetail/Expansion_content.dart';
import 'package:bt_bili/widget/videoDetail/video_header.dart';
import 'package:bt_bili/widget/videoDetail/video_toolbar.dart';
import 'package:bt_bili/widget/videoDetail/video_view.dart';
import 'package:bt_bili/widget/video_large_card.dart';
import 'package:flutter/material.dart';

import '../util/color.dart';

class VideoDetailsPage extends StatefulWidget {
  final VideoModel videoModel;

  const VideoDetailsPage({super.key, required this.videoModel});

  @override
  State<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage>
    with TickerProviderStateMixin {
  late VideoDetailMo videoDetailMo;
  late TabController _tabController;
  List tabs = ["简介", "评论288"];

  @override
  void initState() {
    super.initState();
    videoDetailMo = VideoDetailMo();
    videoDetailMo.videoInfo = widget.videoModel;
    videoDetailMo.videoList = [];

    _tabController = TabController(length: tabs.length, vsync: this);
    _loadDetail();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Scaffold(
      body: Column(
        children: [
          _buildVideoView(),
          _buildTabNavigation(),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDetailList(),
                Container(child: Text("敬请期待")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _loadDetail() async {
    try {
      VideoDetailMo result = await VideoDetailDao.get(
        widget.videoModel.vid ?? "",
      );
      setState(() {
        videoDetailMo = result;
      });
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on BtNetError catch (e) {
      print(e);
    }
  }

  //视频
  VideoView _buildVideoView() {
    return VideoView(
      url: widget.videoModel.url ?? "",
      cover: widget.videoModel.cover ?? "",
    );
  }

  //视频下方tab导航
  Material _buildTabNavigation() {
    return Material(
      elevation: 5,
      shadowColor: Colors.grey[100],
      child: Container(
        padding: EdgeInsets.only(left: 0),
        height: 39,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_tabBar(), _buildBarrageBtn()],
        ),
      ),
    );
  }

  Widget _tabBar() {
    return TabBar(
      controller: _tabController,
      labelStyle: TextStyle(fontSize: 15),
      labelColor: primary,
      isScrollable: true,
      tabs: tabs.map<Tab>((tab) {
        return Tab(text: tab);
      }).toList(),
    );
  }

  //发送弹幕
  _buildBarrageBtn() {
    return Container();
  }

  //视频详情及列表
  ListView _buildDetailList() {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [..._buildContents(), ..._buildVideoList()],
    );
  }

  List<Widget> _buildContents() {
    return [
      VideoHeader(owner: widget.videoModel.owner),
      ExpansionContent(mo: widget.videoModel),
      VideoToolbar(videoDetailMo: videoDetailMo),
    ];
  }

  _buildVideoList() {
    return videoDetailMo.videoList
        ?.map((VideoModel mo) => VideoLargeCard(videoModel: mo))
        .toList();
  }
}
