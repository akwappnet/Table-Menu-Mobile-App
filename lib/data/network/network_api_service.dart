import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/res/services/api_endpoints.dart';
import 'package:table_menu_customer/utils/helpers.dart';

import '../app_exceptions.dart';

class NetworkApiService extends BaseApiService {

  static final Dio _dio = Dio(BaseOptions(
      baseUrl: ApiEndPoint.baseUrl,
      sendTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 60000),
      connectTimeout: const Duration(milliseconds: 30000),
      followRedirects: false,
      validateStatus: (status) {
        log("@@status : $status");
        return status! < 500;
      }));


  setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (response.statusCode == 401) {
            RequestOptions originalRequest = response.requestOptions;
            // Throw an error to trigger the onError callback
            throw DioException(
              requestOptions: originalRequest,
              response: response,
              error: 'Unauthorized',
              type: DioExceptionType.badResponse,
            );
          }
          // Add your custom logic here for response interception
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            // TODO perform force logout
          }
          // Handle other errors if needed
          return handler.next(error);
        },
      ),
    );
  }

  // to make HTTP requests to an API.
  @override
  Future<Response> getGetApiResponse(String url) async {
    try {
      final token = await getToken();

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
      throw FetchDataExceptions(
          'Error Occured While Communicating with Server');
    }
  }

  @override
  Future<Response> getGetApiResponseWithParams(
      String url, String params) async {
    try {
      final token = await getToken();
      var headers = {
        'Authorization': 'Token $token',
        'Accept': 'application/json'
      };
      var queryParams = {'query': params};
      log("queryParams $queryParams");
      log("headers $headers");
      final response = await _dio
          .get(url,
              options: Options(
                headers: headers,
              ),
              queryParameters: queryParams)
          .timeout(const Duration(seconds: 10));
      return response;
    } on SocketException {
      throw FetchDataExceptions(
          'Error Occured While Communicating with Server');
    }
  }

  // to make HTTP requests to an API.
  @override
  Future<Response> getAuthApiResponse(String url, dynamic data,
      {String? verifyToken}) async {
    try {
      var headers = {
        'HTTP_AUTHORIZATION': 'Token $verifyToken',
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
    } on SocketException {
      throw FetchDataExceptions(
          'Error Occured While Communicating with Server');
    }
  }

  // to make HTTP requests to an API.
  @override
  Future<Response> getPostApiResponse(String url, dynamic data) async {
    try {
      final token = await getToken();
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
      throw FetchDataExceptions(
          'Error Occured While Communicating with Server');
    }
  }

  @override
  Future<Response> getPatchApiResponse(String url, dynamic data) async {
    try {
      final token = await getToken();

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
      throw FetchDataExceptions(
          'Error Occured While Communicating with Server');
    }
  }

  @override
  Future<Response> getPutApiResponse(String url, dynamic data) async {
    try {
      final token = await getToken();
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
      throw FetchDataExceptions(
          'Error Occured While Communicating with Server');
    }
  }

  @override
  Future<Response> getDeleteApiResponse(String url) async {
    try {
      final token = await getToken();

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
                  responseType: ResponseType.json))
          .timeout(const Duration(seconds: 10));

      return response;
    } on SocketException {
      throw FetchDataExceptions(
          'Error Occured While Communicating with Server');
    }
  }
}
