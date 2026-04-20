import 'package:bt_bili/models/video_model.dart';
import 'package:bt_bili/navigator/bt_navigator.dart';
import 'package:bt_bili/navigator/bt_routes.dart';
import 'package:bt_bili/util/format_util.dart';
import 'package:bt_bili/util/view_util.dart';
import 'package:flutter/material.dart';

class VideoLargeCard extends StatelessWidget {
  final VideoModel videoModel;

  const VideoLargeCard({super.key, required this.videoModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BtNavigator.getInstance().onJumpTo(
          RouterStatus.detail,
          args: {"videoModel": videoModel},
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 5),
        padding: EdgeInsets.only(bottom: 6),
        height: 106,
        decoration: BoxDecoration(border: borderLine(context)),
        child: Row(children: [_itemImage(context), _buildContent()]),
      ),
    );
  }

  _itemImage(BuildContext context) {
    double height = 90;
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: Stack(
        children: [
          cachedImage(
            videoModel.cover ?? "",
            width: height * (16 / 9),
            height: height,
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                durationTransform(videoModel.duration ?? 0),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildContent() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 12, bottom: 6, top: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(videoModel.title ?? "", style: TextStyle(fontSize: 12)),
            _buildBottomContent(),
          ],
        ),
      ),
    );
  }

  _buildBottomContent() {
    return Column(
      children: [
        _owner(),
        hiSpace(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ...smallIconText(Icons.ondemand_video, videoModel.view ?? 0),
                hiSpace(width: 6),
                ...smallIconText(Icons.list_alt, videoModel.reply ?? 0),
              ],
            ),
            Icon(Icons.more_vert_sharp, color: Colors.grey, size: 15),
          ],
        ),
      ],
    );
  }

  _owner() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: Colors.grey),
          ),
          child: Text(
            'UP',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        hiSpace(width: 6),
        Text(
          videoModel.owner?.name ?? "",
          style: TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }
}
