//网络错误拦截
import 'package:bt_bili/http/core/bt_error.dart';
import 'package:bt_bili/http/core/bt_net_adapter.dart';
import 'package:bt_bili/http/core/dio_adapter.dart';
import 'package:bt_bili/http/request/baseRequest.dart';
import 'package:flutter/foundation.dart';

typedef BtErrorInterceptor = void Function(BtNetError errorr);

class BtNet {
  BtNet._();

  static BtNet? _instance;
  BtErrorInterceptor? errorInterceptor;

  void setErrorIntercaptor(BtErrorInterceptor) {}

  static BtNet getInstance() {
    _instance ??= BtNet._();
    return _instance!;
  }

  Future<T> fire<T>(BaseRequest request) async {
    BtNetResponse? response;
    var error;
    try {
      response = await _send(request);
    } on BtNetError catch (e) {
      error = e;
    } catch (e) {
      error = e;
    }

    var status = response?.statusCode;
    var btError;
    switch (status) {
      case 200:
        return response?.data;
      case 401:
        btError = NeedLogin();
        break;
      case 403:
        btError = NeedAuth("请先登录", data: response?.data);
        break;
      default:
        throw BtNetError(status ?? -1, "服务器错误", data: response?.data);
    }

    if (errorInterceptor != null) {
      errorInterceptor!(btError);
    }
    throw btError;
  }

  Future<BtNetResponse<T>> _send<T>(BaseRequest request) async {
    BtNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    if (kDebugMode) {
      print('fw_net:$log');
    }
  }
}
