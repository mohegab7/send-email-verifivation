import 'package:dio/dio.dart';
import 'package:flutter_application_1/shared/remote/end_points.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
          baseUrl: BASE_URL,
          receiveDataWhenStatusError: true,
          ),
    );
  }

  static Future<Response> getData({
    required String url,
    String? token,
    Map<String, dynamic>? query,
  }) {
    return dio.get(
      url,
      options: Options(
        headers: {
          'lang': 'en',
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      ),
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required Map<String, dynamic> data,
    required String url,
    String? token,
    Map<String, dynamic>? query,
  }) {
    return dio.post(
      url,
      data: data,
      queryParameters: query,
      options: Options(
        headers: {
          'lang': 'en',
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      ),
    );
  }

  static Future<Response> putData({
    required Map<String, dynamic> data,
    required String url,
    String? token,
    Map<String, dynamic>? query,
  }) {
    return dio.put(
      url,
      data: data,
      queryParameters: query,
      options: Options(
        headers: {
          'lang': 'en',
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      ),
    );
  }
}
