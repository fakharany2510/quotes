import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:quotes/core/network/api_constance.dart';
class AppInterceptors extends Interceptor{
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler) ;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers.addAll({
    //   'X-Api-Key':ApiConstance.apiKey
    // });
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }
  
}