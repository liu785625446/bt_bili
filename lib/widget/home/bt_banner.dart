import 'package:bt_bili/models/banner_model.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class BtBanner extends StatelessWidget {
  final List<BannerModel> bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry? padding;

  const BtBanner({
    super.key,
    required this.bannerList,
    this.bannerHeight = 160,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (context, index) {
          return _image(bannerList[index]);
        },
        pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          builder: DotSwiperPaginationBuilder(
            color: Colors.white60,
            size: 6,
            activeSize: 6,
          ),
        ),
      ),
    );
  }

  Widget _image(BannerModel banner) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          child: Image.network(banner.cover ?? "", fit: BoxFit.cover),
        ),
      ),
    );
  }
}
