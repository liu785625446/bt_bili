import 'package:bt_bili/models/video_model.dart';

class RankingModel {
  int? total;
  List<VideoModel>? list;

  RankingModel({this.total, this.list});

  RankingModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    final rawList = json['list'] ?? json['videoList'];
    if (rawList != null) {
      list = <VideoModel>[];
      rawList.forEach((v) {
        list!.add(new VideoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
