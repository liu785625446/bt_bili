import 'package:bt_bili/http/core/bt_net.dart';
import 'package:bt_bili/http/request/ranking_request.dart';
import 'package:bt_bili/models/ranking_model.dart';

class RankingDao {
  static get(String sort, {int pageIndex = 1, pageSize = 10}) async {
    RankingRequest request = RankingRequest();
    request
        .add('sort', sort)
        .add('pageIndex', pageIndex)
        .add('pageSize', pageSize);
    var result = await BtNet.getInstance().fire(request);
    return RankingModel.fromJson(result['data'] ?? {});
  }
}
