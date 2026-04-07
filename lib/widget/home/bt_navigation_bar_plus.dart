import 'package:flutter/material.dart';

class BtNavigationBarPlus extends StatefulWidget {
  final Color color;
  final double height;
  final Widget child;

  const BtNavigationBarPlus({
    super.key,
    required this.color,
    required this.height,
    required this.child,
  });

  @override
  State<BtNavigationBarPlus> createState() => _BtNavigationBarPlusState();
}

class _BtNavigationBarPlusState extends State<BtNavigationBarPlus> {
  @override
  Widget build(BuildContext context) {
    //状态栏高度
    var top = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: top),
      width: MediaQuery.of(context).size.width,
      height: widget.height + top,
      decoration: BoxDecoration(color: widget.color),

      child: widget.child,
    );
  }
}
