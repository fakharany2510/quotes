import 'dart:convert';
import 'dart:io';
import 'package:dio/io.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:quotes/core/api/api_consumer.dart';
import 'package:quotes/core/api/app_interceptors.dart';
import 'package:quotes/core/api/end_points.dart';
import 'package:quotes/core/api/status_code.dart';
import 'package:quotes/core/error/Exceptions.dart';
import 'package:quotes/injection_container.dart' as di;


class DioConsumer implements ApiConsumer{
  final Dio dio;
  DioConsumer({required this.dio}){
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dio) {
      dio.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return dio;
  };

    dio.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    dio.interceptors.add(di.sl<AppInterceptors>());
    /// i do this check because i need to use the loginInterseptor in debug mode only
    if(kDebugMode){
      dio.interceptors.add(di.sl<LogInterceptor>());
    }
}

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters})async {
    try {
      final response = await dio.get(
          path, queryParameters: queryParameters);
      return _handelResponseAsJson(response);
    } on DioException catch(exception){
      _handlerDioException(exception);
    }
  }

  @override
  Future post(String path, {Map<String, dynamic>? body,bool formDataIsEnabled = false, Map<String, dynamic>? queryParameters}) async{
    try {
      final response = await dio.post(
          path, queryParameters: queryParameters, data: formDataIsEnabled ? FormData.fromMap(body!):body);
      return _handelResponseAsJson(response);
    } on DioException catch(exception){
      _handlerDioException(exception);
    }
  }

  @override
  Future put(String path, {Map<String, dynamic>? body, Map<String, dynamic>? queryParameters}) async{
    try {
      final response = await dio.put(
          path, queryParameters: queryParameters, data: body);
      return _handelResponseAsJson(response);
    } on DioException catch(exception){
      _handlerDioException(exception);
    }
  }

  dynamic _handelResponseAsJson(Response<dynamic> response){
    final responseJson=jsonDecode(response.data.toString());
    return responseJson;
  }

  dynamic _handlerDioException(DioException exception){
    switch(exception.type){
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const FetchDataException();
      case DioExceptionType.badResponse:
        switch(exception.response?.statusCode){
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unAuthorized:
          case StatusCode.forbidden:
            throw const UnauthorizedException();
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.conflect:
            throw const ConflictException();
          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionError:
        throw const NoInternetConnectionException();
      case DioExceptionType.badCertificate:
        throw const NoInternetConnectionException();
      default:
        break;
    }
  }

}