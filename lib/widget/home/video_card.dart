import 'package:bt_bili/models/video_model.dart';
import 'package:bt_bili/navigator/bt_navigator.dart';
import 'package:bt_bili/navigator/bt_routes.dart';
import 'package:bt_bili/util/format_util.dart';
import 'package:bt_bili/util/view_util.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final VideoModel videoModel;

  const VideoCard({super.key, required this.videoModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BtNavigator.getInstance().onJumpTo(
            RouterStatus.detail, args: {'videoModel': videoModel});
      },
      child: SizedBox(
        height: 200,
        child: Card(
          margin: EdgeInsets.only(left: 4, right: 4, bottom: 8),
          child: Column(children: [_itemImage(context), _infoText()]),
        ),
      ),
    );
  }

  Stack _itemImage(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Stack(
      children: [
        cachedImage(
          videoModel.cover ?? "",
          height: 120,
          width: size.width / 2 - 10,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black54, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconText(Icons.ondemand_video, videoModel.view),
                _iconText(Icons.favorite_border, videoModel.favorite),
                _iconText(null, videoModel.favorite),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _iconText(IconData? icon, int? count) {
    String views = "";
    if (icon != null) {
      views = countFormat(count ?? 0);
    } else {
      views = durationTransform(count ?? 0);
    }
    return Row(
      children: [
        if (icon != null) Icon(icon, color: Colors.white, size: 12),
        Padding(
          padding: EdgeInsets.only(left: 3),
          child: Text(
            views,
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      ],
    );
  }

  _infoText() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              videoModel.title ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
            ),
            _owner(),
          ],
        ),
      ),
    );
  }

  _owner() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: cachedImage(
                videoModel.owner?.face ?? "",
                width: 24,
                height: 24,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                videoModel.owner?.name ?? "",
                style: TextStyle(fontSize: 11),
              ),
            ),
          ],
        ),
        Icon(Icons.more_vert_sharp, size: 15, color: Colors.grey),
      ],
    );
  }
}
