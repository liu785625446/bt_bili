import 'package:bt_bili/http/core/bt_error.dart';
import 'package:bt_bili/http/core/bt_net_adapter.dart';
import 'package:bt_bili/http/request/baseRequest.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioAdapter extends BtNetAdapter {
  Dio dio = Dio();

  DioAdapter() {
    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args) {
          if (options.path.contains('/posts')) {
            return false;
          }
          // don't print responses with unit8 list data
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );
  }

  @override
  Future<BtNetResponse<T>> send<T>(BaseRequest request) async {
    var response, options = Options(headers: request.headers);
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await dio.get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await dio.post(
          request.url(),
          data: request.params,
          options: options,
        );
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await dio.delete(
          request.url(),
          data: request.params,
          options: options,
        );
      }
    } on DioException catch (e) {
      error = e;
      response = e.response;
    }

    if (error != null) {
      throw BtNetError(
        response.statusCode ?? -1,
        error.toString(),
        data: buildRes(response, request),
      );
    }
    return buildRes(response, request);
  }

  Future<BtNetResponse<T>> buildRes<T>(
    Response? response,
    BaseRequest request,
  ) {
    return Future.value(
      BtNetResponse(
        data: response?.data,
        request: request,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
        extra: response,
      ),
    );
  }
}
