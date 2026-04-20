import 'package:bt_bili/models/video_model.dart';
import 'package:bt_bili/util/view_util.dart';
import 'package:flutter/material.dart';

class ExpansionContent extends StatefulWidget {
  final VideoModel mo;

  const ExpansionContent({super.key, required this.mo});

  @override
  State<ExpansionContent> createState() => _ExpansionContentState();
}

class _ExpansionContentState extends State<ExpansionContent>
    with TickerProviderStateMixin {
  static final Animatable<double> _easeInTween = CurveTween(
    curve: Curves.easeIn,
  );
  bool _expand = false;

  //用来管理animatio
  late AnimationController _controller;

  //生成动画高度的值
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _heightFactor = _controller.drive(_easeInTween);
    _controller.addListener(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
      child: Column(children: [_buildTitle(), _buildInfo(), _buildDes()]),
    );
  }

  InkWell _buildTitle() {
    return InkWell(
      onTap: () {
        setState(() {
          _expand = !_expand;
          if (_expand) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //通过Expanded让Text获得最大宽度，以便显示...
          Expanded(
            child: Text(
              widget.mo.title ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(
            _expand
                ? Icons.keyboard_arrow_up_sharp
                : Icons.keyboard_arrow_down_sharp,
            color: Colors.grey,
            size: 16,
          ),
        ],
      ),
    );
  }

  Row _buildInfo() {
    var style = TextStyle(fontSize: 12, color: Colors.grey);

    return Row(
      children: [
        ...smallIconText(Icons.ondemand_video, widget.mo.view),
        Padding(padding: EdgeInsets.only(left: 10)),
        ...smallIconText(Icons.list_alt, widget.mo.reply),
        Padding(padding: EdgeInsets.only(left: 10)),
        Text(widget.mo.createTime ?? "", style: style),
      ],
    );
  }

  AnimatedBuilder _buildDes() {
    var child = _expand
        ? Text(
            widget.mo.desc ?? "",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )
        : null;

    //构建动画的通用widget
    return AnimatedBuilder(
      animation: _controller.view,
      child: child,
      builder: (BuildContext context, Widget? child) {
        return Align(
          heightFactor: _heightFactor.value,
          alignment: Alignment.topCenter,
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 8),
            child: child,
          ),
        );
      },
    );
  }
}
