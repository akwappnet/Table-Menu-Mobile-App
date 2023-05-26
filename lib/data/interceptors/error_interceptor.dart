import 'dart:io';
import 'package:dio/dio.dart';
import '../app_exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    if (error.response?.statusCode == 401) {
      throw UnauthorisedException('UnauthorizedException');
    } else if (error.error is SocketException) {
      throw FetchDataExceptions('No Internet Connection');
    } else {
      throw FetchDataExceptions('Error Occurred While Communicating with Server');
    }
  }
}