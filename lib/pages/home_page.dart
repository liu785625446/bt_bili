import 'package:bt_bili/navigator/bt_navigator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var listener;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listener = BtNavigator.getInstance().registerStatePage(
      widget,
      onResue: () {
        print("首页打开");
      },
      onPause: () {
        print("首页关闭");
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    BtNavigator.getInstance().removeListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("home")),
      body: Text("home"),
    );
  }
}
