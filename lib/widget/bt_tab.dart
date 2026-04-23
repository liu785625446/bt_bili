import 'package:bt_bili/util/color.dart';
import 'package:flutter/material.dart';

class BtTab extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final double? fontSize;
  final double? borderWidth;
  final double? inset;
  final Color? unSelectedLabelColor;

  const BtTab({
    super.key,
    required this.tabs,
    this.controller,
    this.fontSize = 14,
    this.borderWidth = 1,
    this.inset = 15,
    this.unSelectedLabelColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: tabs,
      controller: controller,
      isScrollable: true,
      labelColor: primary,
      unselectedLabelColor: unSelectedLabelColor,
      labelStyle: TextStyle(fontSize: fontSize),
    );
  }
}
