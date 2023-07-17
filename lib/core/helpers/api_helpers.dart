import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:media_probe/core/constants/secrets.dart';

class ApiBaseHelper {
  ApiBaseHelper._();

  static final ApiBaseHelper _instance = ApiBaseHelper._();

  factory ApiBaseHelper() {
    return _instance;
  }

  static BaseOptions options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    contentType: 'application/json',
    headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );

  static Dio dio = Dio(options);
  var responseJson = <String, dynamic>{};

  Future<Dio> getApiClient() async {
    var retry = 0;
    dio.interceptors.clear();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (request, handler) async {
      return handler.next(request);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }, onError: (err, handler) async {
      if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
        final opts = Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers);
        final cloneReq = await dio.request(err.requestOptions.path,
            options: opts,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters);

        return handler.resolve(cloneReq);
      } else if ((err.type == DioExceptionType.connectionTimeout ||
              err.type == DioExceptionType.receiveTimeout) &&
          retry < 1) {
        retry++;
        final cloneReq = await dio.request(err.requestOptions.path,
            options: Options(
                method: err.requestOptions.method,
                headers: err.requestOptions.headers),
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters);
        return handler.resolve(cloneReq);
      }
      return handler.reject(err);
    }));
    return dio;
  }

  Future<dynamic> get(
      {required String url, Map<String, dynamic>? queryParameters}) async {
    Response response;
    try {
      final client = await getApiClient();
      response = await client.get(url, queryParameters: queryParameters);
      responseJson = _returnResponse(
          response: response, queryParameters: queryParameters, url: url);
    } catch (e) {
      debugPrint(e.toString());
    }
    return responseJson;
  }

  dynamic _returnResponse(
      {required String url,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? body,
      required Response<dynamic> response}) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        debugPrint('-------');
        debugPrint(
            'Url: $url, Body: ${body.toString()}  QueryParameters: ${queryParameters.toString()}');
        debugPrint('-------');
        return responseJson;
      case 400:
        debugPrint('bad request: ${response.data.toString()}');
      case 401:
      case 403:
        debugPrint('unauthorized: ${response.data.toString()}');
      case 409:
        debugPrint('conflict: ${response.data.toString()}');
      case 500:
      default:
        debugPrint('error occured: ${response.data.toString()}');
    }
  }
}
