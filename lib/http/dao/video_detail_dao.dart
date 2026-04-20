import 'package:bt_bili/http/core/bt_net.dart';
import 'package:bt_bili/http/request/video_detail_request.dart';
import 'package:bt_bili/models/video_detail_mo.dart';

class VideoDetailDao {
  static get(String vid) async {
    VideoDetailRequest request = VideoDetailRequest();
    request.pathParams = vid;
    var result = await BtNet.getInstance().fire(request);
    return VideoDetailMo.fromJson(result['data']);
  }
}
