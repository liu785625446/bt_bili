import 'package:bt_bili/http/core/bt_net.dart';
import 'package:bt_bili/http/request/favorite_list_request.dart';
import 'package:bt_bili/models/ranking_model.dart';

class FavoriteListDao {
  static get({int pageIndex = 1, int pageSize = 10}) async {
    FavoriteListRequest request = FavoriteListRequest();
    request.add('pageIndex', pageIndex).add('pageSize', pageSize);
    var result = await BtNet.getInstance().fire(request);
    return RankingModel.fromJson(result['data']);
  }
}
