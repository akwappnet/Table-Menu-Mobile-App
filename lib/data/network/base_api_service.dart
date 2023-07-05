
import 'package:dio/dio.dart';

abstract class BaseApiService {
  Future<Response> getGetApiResponse(String url);
  Future<Response> getAuthApiResponse(String url, dynamic data,{String? verifyToken});
  Future<Response> getPostApiResponse(String url, dynamic data);
  Future<Response> getPatchApiResponse(String url, dynamic data);
  Future<Response> getDeleteApiResponse(String url);
  Future<Response> getGetApiResponseWithParams(String url, String params);
  Future<Response> getPutApiResponse(String url, dynamic data);
}