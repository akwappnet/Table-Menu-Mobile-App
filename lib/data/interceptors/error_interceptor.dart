import 'dart:io';
import 'package:dio/dio.dart';
import '../app_exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      throw UnauthorisedException('UnauthorizedException');
    } else if (err.error is SocketException) {
      throw FetchDataExceptions('No Internet Connection');
    } else {
      throw FetchDataExceptions('Error Occurred While Communicating with Server');
    }
  }
}