import 'package:bt_bili/db/bt_cache.dart';
import 'package:bt_bili/navigator/bt_route_delegate.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BtBili());
}

class BtBili extends StatefulWidget {
  const BtBili({super.key});

  @override
  State<BtBili> createState() => _BtBiliState();
}

class _BtBiliState extends State<BtBili> {
  final BtRouteDelegate _routeDelegate = BtRouteDelegate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BtCache.preInit(),
      builder: (BuildContext context, AsyncSnapshot<BtCache> snapshot) {
        var widget = snapshot.connectionState == ConnectionState.done
            ? Router(routerDelegate: _routeDelegate)
            : Scaffold(body: Center(child: CircularProgressIndicator()));
        return MaterialApp(home: widget);
      },
    );
  }
}
