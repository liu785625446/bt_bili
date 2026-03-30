//网络请求抽象类
import 'dart:convert';

import 'package:bt_bili/http/request/baseRequest.dart';

abstract class BtNetAdapter {
  Future<BtNetResponse<T>> send<T>(BaseRequest request);
}

//统一网络层返回格式
class BtNetResponse<T> {
  T? data;
  BaseRequest? request;
  int? statusCode;
  String? statusMessage;
  dynamic extra;

  BtNetResponse({
    this.data,
    this.request,
    this.statusCode,
    this.statusMessage,
    this.extra,
  });

  // String toString() {
  //   if (data is Map) {
  //     return json.encode(data);
  //   }
  //   return data.toString();
  // }
}
