import 'package:bt_bili/models/profile_model.dart';
import 'package:bt_bili/widget/bt_blur.dart';
import 'package:flutter/material.dart';

class BenefitCard extends StatelessWidget {
  final List<BenefitModel> benefitList;

  const BenefitCard({super.key, required this.benefitList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 5, top: 15),
      child: Column(children: [_buildTitle(), _buildFenefitCard(context)]),
    );
  }

  _buildTitle() {
    return Container(
      child: Row(
        children: [
          Text(
            "增值服务",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8, height: 1),
          Text(
            "购买后登录慕课网再次点击打开查看",
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  _buildFenefitCard(BuildContext context) {
    var width =
        (MediaQuery.of(context).size.width -
            20 -
            (benefitList.length - 1) * 5) /
        benefitList.length;
    return Row(
      children: [...benefitList.map((e) => _buildCard(context, e, width))],
    );
  }

  _buildCard(BuildContext context, BenefitModel e, double width) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(right: 5, bottom: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            alignment: Alignment.center,
            width: width,
            height: 60,
            decoration: BoxDecoration(color: Colors.deepOrangeAccent),
            child: Stack(
              children: [
                Positioned.fill(child: BtBlur(sigma: 5)),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      e.name ?? "",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
