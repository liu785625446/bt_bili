import 'package:bt_bili/http/request/baseRequest.dart';

class ProfileRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  String path() {
    return "uapi/fa/profile";
  }
}
