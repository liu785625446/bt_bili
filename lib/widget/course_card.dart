import 'package:bt_bili/models/profile_model.dart';
import 'package:bt_bili/util/view_util.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final List<CourseModel> courseList;

  const CourseCard({super.key, required this.courseList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 5, top: 15),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "职场进阶",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8, height: 1),
              Text(
                "带你突破技术瓶颈",
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
          ..._buildCardList(context),
        ],
      ),
    );
  }

  _buildCardList(BuildContext context) {
    var courseGroup = Map();

    //将课程进行分组
    courseList.forEach((mo) {
      if (!courseGroup.containsKey(mo.group ?? 0)) {
        courseGroup[mo.group ?? 0] = [];
      }
      List list = courseGroup[mo.group ?? 0];
      list.add(mo);
    });

    return courseGroup.entries.map((e) {
      List list = e.value;

      //根据卡片数量计算出每个卡片的宽度
      var width =
          (MediaQuery.of(context).size.width - 20 - (list.length - 1) * 5) /
          list.length;
      var height = width / 16 * 6;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [...list.map((mo) => _buildCard(mo, width, height))],
      );
    });
  }

  _buildCard(CourseModel mo, double width, double height) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(right: 5, bottom: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: cachedImage(mo.cover ?? "", width: width, height: height),
        ),
      ),
    );
  }
}
