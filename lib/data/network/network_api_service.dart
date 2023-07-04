import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/res/services/api_endpoints.dart';

import '../app_exceptions.dart';
import '../interceptors/auth_interceptor.dart';
import '../interceptors/error_interceptor.dart';

class NetworkApiService extends BaseApiService {
  final Dio _dio = Dio(
      BaseOptions(
          baseUrl: ApiEndPoint.baseUrl,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          })
  );

  NetworkApiService() {
    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(ErrorInterceptor());
  }

  // to make HTTP requests to an API.
  @override
  Future<Response> getGetApiResponse(String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var headers = {
        'Authorization': 'Token $token',
        'Accept': 'application/json'
      };

      final response = await _dio
          .get(url,
              options: Options(
                headers: headers,
              ))
          .timeout(const Duration(seconds: 10));
      //print(response.data);
      return response;
      // responseJson = returnResponse(response);
      // return responseJson;
    } on SocketException {
      throw FetchDataExceptions('Error Occured While Communicating with Server');
    }
  }

  @override
  Future<Response> getGetApiResponseWithParams(
      String url, String params) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var headers = {
        'Authorization': 'Token $token',
        'Accept': 'application/json'
      };
      var queryParams = {'query': params};

      final response = await _dio
          .get(url,
              options: Options(
                headers: headers,
              ),
              queryParameters: queryParams)
          .timeout(const Duration(seconds: 10));
      //print(response.data);
      return response;
      // responseJson = returnResponse(response);
      // return responseJson;
    } on SocketException {
      throw FetchDataExceptions('Error Occured While Communicating with Server');
    }
  }

  // to make HTTP requests to an API.
  @override
  Future<Response> getAuthApiResponse(String url, dynamic data) async {
    // dynamic responseJson;
    try {
      var response = await _dio
          .post(
            url,
            data: data,
          )
          .timeout(const Duration(seconds: 10));

      return response;
      // responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExceptions('Error Occured While Communicating with Server');
    }
    // return responseJson;
  }

  // to make HTTP requests to an API.
  @override
  Future<Response> getPostApiResponse(String url, dynamic data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      var headers = {
        'Authorization': 'Token $token',
        'Accept': 'application/json'
      };

      var response = await _dio
          .post(url,
              data: data,
              options: Options(
                  headers: headers,
                  validateStatus: (_) => true,
                  contentType: Headers.jsonContentType,
                  responseType: ResponseType.json))
          .timeout(const Duration(seconds: 10));

      return response;
      // responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExceptions('Error Occured While Communicating with Server');
    }
  }

  @override
  Future<Response> getPatchApiResponse(String url, dynamic data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var headers = {
        'Authorization': 'Token $token',
        'Accept': 'application/json'
      };

      var response = await _dio
          .patch(url,
              data: data,
              options: Options(
                headers: headers,
                validateStatus: (_) => true,
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
              ))
          .timeout(const Duration(seconds: 10));

      return response;
      // responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExceptions('Error Occured While Communicating with Server');
    }
  }

  @override
  Future<Response> getPutApiResponse(String url, dynamic data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var headers = {
        'Authorization': 'Token $token',
        'Accept': 'application/json'
      };

      var response = await _dio
          .put(url,
          data: data,
          options: Options(
            headers: headers,
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ))
          .timeout(const Duration(seconds: 10));

      return response;
      // responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExceptions('Error Occured While Communicating with Server');
    }
  }

  @override
  Future<Response> getDeleteApiResponse(String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var headers = {
        'Authorization': 'Token $token',
         'Accept': 'application/json'
      };

      var response = await _dio
          .delete(url,
              options: Options(
                headers: headers,
                validateStatus: (_) => true,
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json
              )
      )
          .timeout(const Duration(seconds: 10));

      return response;
    } on SocketException {
      throw FetchDataExceptions('Error Occured While Communicating with Server');
    }
  }
}
