import 'package:coordinator_app/shared/remote/network/end_points.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static intial() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    };
    return await dio!.post(url, data: data, queryParameters: query);
  }

  static Future<Response> postData_For_Login({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
    };
    return await dio!.post(url, data: data, queryParameters: query);
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? quary,
    required String token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    };
    return await dio!.get(url, queryParameters: quary);
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    required String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Token ${token}',
      'Content-Type': 'application/json',
    };
    return await dio!.put(url, data: data, queryParameters: query);
  }

  static Future<Response> patchData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    required String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${token}',
    };
    return await dio!.patch(url, data: data, queryParameters: query);
  }

  static deleteData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    required String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${token}',
    };
    return await dio!.delete(url, data: data, queryParameters: query);
  }
}
