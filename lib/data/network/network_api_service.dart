import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:table_menu_customer/data/db_provider.dart';
import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/utils/services/api_endpoints.dart';

import '../../utils/helpers.dart';

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
          BuildContext? context = AppContext.navigatorKey.currentContext;
          if (error.response?.statusCode == 401) {
            handleDioException(context!, error);
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
      final token = await DatabaseProvider().getToken();

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
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> getGetApiResponseWithParams(
      String url, dynamic queryParams) async {
    try {
      final token = await DatabaseProvider().getToken();
      var headers = {
        'Authorization': 'Token $token',
        'Accept': 'application/json'
      };
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
    } catch (e) {
      rethrow;
    }
  }

  // to make HTTP requests to an API.
  @override
  Future<Response> getAuthApiResponse(String url, dynamic data,
      {String? verifyToken}) async {
    try {
      var headers = {
        'Authorization': 'Token $verifyToken',
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
    } catch (e) {
      rethrow;
    }
  }

  // to make HTTP requests to an API.
  @override
  Future<Response> getPostApiResponse(String url, dynamic data) async {
    try {
      final token = await DatabaseProvider().getToken();
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
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> getPatchApiResponse(String url, dynamic data) async {
    try {
      final token = await DatabaseProvider().getToken();

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
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> getPutApiResponse(String url, dynamic data) async {
    try {
      final token = await DatabaseProvider().getToken();
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
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> getDeleteApiResponse(String url) async {
    try {
      final token = await DatabaseProvider().getToken();

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
    } catch (e) {
      rethrow;
    }
  }
}
