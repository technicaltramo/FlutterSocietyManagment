import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:t_society/res/string.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/service/dio/connection.dart';
import 'exception.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class DioClient {
  Dio dio;
  AppPreference appPreference;
  DioClient(this.appPreference) {
    dio = Dio();
    dio
      ..options.baseUrl = AppString.BASE_URL
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions option) async {
      bool isConnectionAvailable = await NetworkConnection.isConnection();
      if (!isConnectionAvailable) throw NoInternetException();
      return option;
    }));

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: true,
          request: true,
          requestBody: true));
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      if (appPreference.token != null)
        dio.options.headers["authorization"] = "${appPreference.token}";
      var response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      if (appPreference.token != null)
        dio.options.headers["authorization"] = "${appPreference.token}";
      var response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> patch(
    String uri, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      var response = await dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
  }) async {
    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      throw e;
    }
  }
}
