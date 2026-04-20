//视频点赞分享收藏等工具栏
import 'package:bt_bili/models/video_detail_mo.dart';
import 'package:bt_bili/util/color.dart';
import 'package:bt_bili/util/format_util.dart';
import 'package:bt_bili/util/view_util.dart';
import 'package:flutter/material.dart';

class VideoToolbar extends StatelessWidget {
  final VideoDetailMo videoDetailMo;
  final VoidCallback? onLike;
  final VoidCallback? onUnLike;
  final VoidCallback? onCoin;
  final VoidCallback? onFavorite;
  final VoidCallback? onShare;

  const VideoToolbar({
    super.key,
    required this.videoDetailMo,
    this.onLike,
    this.onUnLike,
    this.onCoin,
    this.onFavorite,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(border: borderLine(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText(
            Icons.thumb_up_alt_rounded,
            videoDetailMo.videoInfo?.like ?? 0,
            onClick: onLike,
            tint: videoDetailMo.isLike ?? false,
          ),
          _buildIconText(
            Icons.thumb_down_alt_rounded,
            '不喜欢',
            onClick: onUnLike,
          ),
          _buildIconText(
            Icons.monetization_on,
            videoDetailMo.videoInfo?.coin ?? 0,
            onClick: onCoin,
          ),
          _buildIconText(
            Icons.grade_rounded,
            videoDetailMo.videoInfo?.favorite ?? 0,
            onClick: onFavorite,
            tint: videoDetailMo.isFavorite ?? false,
          ),
          _buildIconText(
            Icons.share_rounded,
            videoDetailMo.videoInfo?.share ?? 0,
            onClick: onShare,
          ),
        ],
      ),
    );
  }

  InkWell _buildIconText(
    IconData iconData,
    text, {
    onClick,
    bool tint = false,
  }) {
    if (text is int) {
      //显示格式化
      text = countFormat(text);
    } else {
      text = text;
    }
    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          Icon(iconData, color: tint ? primary : Colors.grey, size: 20),
          hiSpace(height: 5),
          Text(text, style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
