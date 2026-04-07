import 'package:bt_bili/http/core/bt_net.dart';
import 'package:bt_bili/http/request/home_request.dart';
import 'package:bt_bili/models/home_mo.dart';

class HomeDao {
  static get(String categoryName, {int pageIndex = 1, int pageSize = 1}) async {
    HomeRequest request = HomeRequest();
    request.pathParams = categoryName;
    request.add("pageIndex", pageIndex).add('pageSize', pageSize);
    var result = await BtNet.getInstance().fire(request);
    print(result);
    return HomeMo.fromJson(result['data']);
  }
}
