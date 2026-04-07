import 'package:flutter/cupertino.dart';

abstract class BtState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    } else {
      print("HiState:页面不存在，本次setState不执行：${toString()}");
    }
  }
}
