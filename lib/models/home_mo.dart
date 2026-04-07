import 'package:bt_bili/models/banner_model.dart';
import 'package:bt_bili/models/video_model.dart';

class HomeMo {
  List<BannerModel>? bannerList;
  List<CategoryModel>? categoryList;
  List<VideoModel>? videoList;

  HomeMo({this.bannerList, this.categoryList, this.videoList});

  HomeMo.fromJson(Map<String, dynamic> json) {
    if (json['bannerList'] != null) {
      bannerList = <BannerModel>[];
      json['bannerList'].forEach((v) {
        bannerList!.add(new BannerModel.fromJson(v));
      });
    }
    if (json['categoryList'] != null) {
      categoryList = <CategoryModel>[];
      json['categoryList'].forEach((v) {
        categoryList!.add(new CategoryModel.fromJson(v));
      });
    }
    if (json['videoList'] != null) {
      videoList = <VideoModel>[];
      json['videoList'].forEach((v) {
        videoList!.add(new VideoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bannerList != null) {
      data['bannerList'] = this.bannerList!.map((v) => v.toJson()).toList();
    }
    if (this.categoryList != null) {
      data['categoryList'] = this.categoryList!.map((v) => v.toJson()).toList();
    }
    if (this.videoList != null) {
      data['videoList'] = this.videoList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryModel {
  String? name;
  int? count;

  CategoryModel({this.name, this.count});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}
