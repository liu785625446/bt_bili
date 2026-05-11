import 'package:bt_bili/util/view_util.dart';
import 'package:flutter/material.dart';

///可动态改变位置的header组件
///性能优化：局部刷新的应用@刷新原理
class BtFlexibleHeader extends StatefulWidget {
  final String name;
  final String face;
  final ScrollController _scrollController;

  const BtFlexibleHeader({
    super.key,
    required this.name,
    required this.face,
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
      print("offset$offset");
      //算出padding 变化0-1
      var dyOffset = (MAX_OFFSET - offset) / MAX_OFFSET;
      //根据dyOffset算出具体的变化的padding值
      var dy = dyOffset * (MAX_BOTTOM - MIN_BOTTOM);
      //临界值保护
      if (dy > (MAX_BOTTOM - MIN_BOTTOM)) {
        dy = MAX_BOTTOM - MIN_BOTTOM;
      } else if (dy < 0) {
        dy = 0;
      }
      setState(() {
        //算出实际的padding
        _dyBottom = MIN_BOTTOM + dy;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, bottom: _dyBottom),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: cachedImage(widget.face, width: 46),
          ),
          SizedBox(width: 8, height: 1),
          Text(widget.name, style: TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}
