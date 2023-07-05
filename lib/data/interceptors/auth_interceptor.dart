import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    // options.headers['Authorization'] = 'Token $token';
    // options.headers['Accept'] = 'application/json';
    handler.next(options);
  }
}