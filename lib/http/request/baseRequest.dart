import 'package:bt_bili/db/bt_cache.dart';
import 'package:bt_bili/http/dao/login_dao.dart';
import 'package:bt_bili/util/user_costants.dart';

enum HttpMethod { GET, POST, DELETE }

abstract class BaseRequest {
  var pathParams;
  var useHttps = true;

  Map<String, String> params = {};
  Map<String, String> headers = {
    UserCostants.courseFlagK: UserCostants.courseFlagV,
    UserCostants.authTokenK: UserCostants.authTokenV,
  };

  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();

  String path();

  bool needLogin();

  String url() {
    Uri uri;
    var pathStr = path();

    //拼接path参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }

    //http和https切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }

    if (needLogin()) {
      addHeader(UserCostants.BOARDING_PASS, LoginDao.getBoardingPass());
    }

    print('url:${uri.toString()}');
    return uri.toString();
  }

  //添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  //添加header
  BaseRequest addHeader(String k, Object v) {
    headers[k] = v.toString();
    return this;
  }
}
