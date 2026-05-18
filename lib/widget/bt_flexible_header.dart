import 'dart:io';

import 'package:bt_bili/util/view_util.dart';
import 'package:flutter/material.dart';

///可动态改变位置的header组件
///性能优化：局部刷新的应用@刷新原理
class BtFlexibleHeader extends StatefulWidget {
  final String name;
  final String face;
  /// 本地选取的头像路径；若有值则优先于 [face] 网络图展示
  final String? localAvatarPath;
  final VoidCallback? onAvatarTap;
  final ScrollController _scrollController;

  const BtFlexibleHeader({
    super.key,
    required this.name,
    required this.face,
    this.localAvatarPath,
    this.onAvatarTap,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  @override
  State<BtFlexibleHeader> createState() => _BtFlexibleHeaderState();
}

class _BtFlexibleHeaderState extends State<BtFlexibleHeader> {
  static const double MAX_BOTTOM = 40;
  static const double MIN_BOTTOM = 10;

  //滚动范围
  static const MAX_OFFSET = 80;

  double _dyBottom = MAX_BOTTOM;

  @override
  void initState() {
    super.initState();
    widget._scrollController.addListener(() {
      var offset = widget._scrollController.offset;
      var dyOffset = (MAX_OFFSET - offset) / MAX_OFFSET;
      var dy = dyOffset * (MAX_BOTTOM - MIN_BOTTOM);
      if (dy > (MAX_BOTTOM - MIN_BOTTOM)) {
        dy = MAX_BOTTOM - MIN_BOTTOM;
      } else if (dy < 0) {
        dy = 0;
      }
      setState(() {
        _dyBottom = MIN_BOTTOM + dy;
      });
    });
  }

  Widget _buildAvatar() {
    final path = widget.localAvatarPath;
    Widget image;
    if (path != null && path.isNotEmpty) {
      image = Image.file(
        File(path),
        width: 46,
        height: 46,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => cachedImage(widget.face, width: 46, height: 46),
      );
    } else {
      image = cachedImage(widget.face, width: 46, height: 46);
    }
    image = ClipRRect(
      borderRadius: BorderRadius.circular(23),
      child: image,
    );
    if (widget.onAvatarTap != null) {
      return GestureDetector(
        onTap: widget.onAvatarTap,
        child: image,
      );
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, bottom: _dyBottom),
      child: Row(
        children: [
          _buildAvatar(),
          SizedBox(width: 8, height: 1),
          Text(widget.name, style: TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}
