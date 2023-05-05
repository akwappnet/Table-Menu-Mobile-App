import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../app_exceptions.dart';

class NetworkApiService {

  final Dio _dio = Dio();


  // to make HTTP requests to an API.
  Future<Response> getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Token $token'
      };

      final response = await
      _dio.get(url, options: Options(
        headers: headers,
      ))
          .timeout(const Duration(seconds: 10));
      //print(response.data);
      return response;
      // responseJson = returnResponse(response);
      // return responseJson;
    } on SocketException {
      throw FetchDataExceptions('No Internet Connection');
    }
    return responseJson;
  }


  // to make HTTP requests to an API.
  Future<Response> getAuthApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {

      var response = await _dio
          .post(url, data: data,)
          .timeout(Duration(seconds: 10));

      print(response.data);
      return response;
      // responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExceptions('No Internet Connection');
    }
    return responseJson;
  }


  // to make HTTP requests to an API.
  Future<Response> getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      print(token);
      var headers = {
        'Authorization': 'Token $token',
        'Accept': 'application/json'
      };

      var response = await _dio
          .post(url, data: data,  options: Options(
        headers: headers,
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType:ResponseType.json,
      ))
          .timeout(Duration(seconds: 10));

      print(response.data);
      return response;
      // responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExceptions('No Internet Connection');
    }
    return responseJson;
  }

  Future<Response> getPatchApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var headers = {
        'Authorization': 'Token $token',
        'Accept': 'application/json'
      };

      var response = await _dio
          .patch(url, data: data, options: Options(
        headers: headers,
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType:ResponseType.json,
      ))
          .timeout(Duration(seconds: 10));

      print(response.data);
      return response;
      // responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExceptions('No Internet Connection');
    }
    return responseJson;
  }

  Future<Response> getDeleteApiResponse(String url) async {
    dynamic responseJson;
    try {

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Token $token'
      };

      var response = await _dio
          .delete(url, options: Options(
        headers: headers,
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType:ResponseType.json,
      ))
          .timeout(Duration(seconds: 10));

      print(response.data);
      return response;
      // responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExceptions('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.data);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.data);
        return responseJson;
      default:
        throw FetchDataExceptions(
            'Error Occured While Communicating with Server');
    }
  }


}