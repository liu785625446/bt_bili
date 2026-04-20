import 'package:bt_bili/http/request/baseRequest.dart';

class VideoDetailRequest extends BaseRequest {
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
    return 'uapi/fa/detail';
  }

}