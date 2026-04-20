import 'package:bt_bili/models/owner.dart';
import 'package:bt_bili/util/color.dart';
import 'package:bt_bili/util/format_util.dart';
import 'package:flutter/material.dart';

class VideoHeader extends StatelessWidget {
  final Owner? owner;

  const VideoHeader({super.key, this.owner});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(owner?.face ?? "", width: 30, height: 30),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      owner?.name ?? "",
                      style: TextStyle(
                        fontSize: 14,
                        color: primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${countFormat(owner?.fans ?? 0)}粉丝',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          MaterialButton(
            onPressed: () {},
            color: primary,
            height: 24,
            minWidth: 50,
            child: Text(
              "+ 关注",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
