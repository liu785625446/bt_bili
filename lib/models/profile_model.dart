import 'package:bt_bili/models/banner_model.dart';

class ProfileModel {
  String? name;
  String? face;
  int? fans;
  int? favorite;
  int? like;
  int? coin;
  int? browsing;
  List<BannerModel>? bannerList;
  List<CourseModel>? courseList;
  List<BenefitModel>? benefitList;

  ProfileModel({
    this.name,
    this.face,
    this.fans,
    this.favorite,
    this.like,
    this.coin,
    this.browsing,
    this.bannerList,
    this.courseList,
    this.benefitList,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    face = json['face'];
    fans = json['fans'];
    favorite = json['favorite'];
    like = json['like'];
    coin = json['coin'];
    browsing = json['browsing'];
    if (json['bannerList'] != null) {
      bannerList = <BannerModel>[];
      json['bannerList'].forEach((v) {
        bannerList!.add(new BannerModel.fromJson(v));
      });
    }
    if (json['courseList'] != null) {
      courseList = <CourseModel>[];
      json['courseList'].forEach((v) {
        courseList!.add(new CourseModel.fromJson(v));
      });
    }
    if (json['benefitList'] != null) {
      benefitList = <BenefitModel>[];
      json['benefitList'].forEach((v) {
        benefitList!.add(new BenefitModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['face'] = this.face;
    data['fans'] = this.fans;
    data['favorite'] = this.favorite;
    data['like'] = this.like;
    data['coin'] = this.coin;
    data['browsing'] = this.browsing;
    if (this.bannerList != null) {
      data['bannerList'] = this.bannerList!.map((v) => v.toJson()).toList();
    }
    if (this.courseList != null) {
      data['courseList'] = this.courseList!.map((v) => v.toJson()).toList();
    }
    if (this.benefitList != null) {
      data['benefitList'] = this.benefitList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseModel {
  String? name;
  String? cover;
  String? url;
  int? group;

  CourseModel({this.name, this.cover, this.url, this.group});

  CourseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cover = json['cover'];
    url = json['url'];
    group = json['group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['cover'] = this.cover;
    data['url'] = this.url;
    data['group'] = this.group;
    return data;
  }
}

class BenefitModel {
  String? name;
  String? url;

  BenefitModel({this.name, this.url});

  BenefitModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
