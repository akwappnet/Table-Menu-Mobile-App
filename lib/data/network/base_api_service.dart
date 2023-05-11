
import 'package:dio/dio.dart';

abstract class BaseApiService {
  Future<Response> getGetApiResponse(String url);
  Future<Response> getAuthApiResponse(String url, dynamic data);
  Future<Response> getPostApiResponse(String url, dynamic data);
  Future<Response> getPatchApiResponse(String url, dynamic data);
  Future<Response> getDeleteApiResponse(String url);
}