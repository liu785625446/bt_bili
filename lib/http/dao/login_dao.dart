import 'package:bt_bili/db/bt_cache.dart';
import 'package:bt_bili/http/core/bt_net.dart';
import 'package:bt_bili/http/request/baseRequest.dart';
import 'package:bt_bili/http/request/login_request.dart';
import 'package:bt_bili/util/user_costants.dart';

import '../request/register_request.dart';

class LoginDao {
  static login(String userName, String password) async {
    LoginRequest request = LoginRequest();
    request.add("userName", userName).add("password", password);
    var result = await _send(request);

    if (result["code"] == 0 && result["data"] != null) {
      //保存登陆令牌
      BtCache.getInstance().setString(
        UserCostants.BOARDING_PASS,
        result["data"] as String,
      );
    }
    return result;
  }

  static register(
    String userName,
    String password,
    String imoocId,
    String orderId,
  ) {
    //imoocId=9761314&orderId=5289
    BaseRequest request = RegisterRequest();
    request
        .add("userName", userName)
        .add("password", password)
        .add("imoocId", imoocId)
        .add("orderId", orderId);
    return _send(request);
  }

  static _send(BaseRequest request) async {
    var result = await BtNet.getInstance().fire(request);
    return result;
  }

  static getBoardingPass() {
    return BtCache.getInstance().get<String>(UserCostants.BOARDING_PASS);
  }
}
