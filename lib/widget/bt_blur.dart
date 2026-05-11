import 'dart:ui';

import 'package:flutter/material.dart';

class BtBlur extends StatelessWidget {
  final Widget? child;

  //模糊值
  final double sigma;

  const BtBlur({super.key, this.child, required this.sigma});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
      child: Container(color: Colors.white10, child: child),
    );
  }
}
