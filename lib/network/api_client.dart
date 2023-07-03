import 'dart:convert';
import 'dart:io';

import 'package:biz_track/shared/utils/constants.dart';
import 'package:biz_track/shared/utils/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioTransformer extends DefaultTransformer {
  DioTransformer() : super(jsonDecodeCallback: parseJson);
}

class ApiClient {
  late Dio http;

  ApiClient() {
    http = Dio(
      BaseOptions(
        baseUrl: "http://192.168.1.54:8080/api",
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        }
      )
    )..interceptors.add(
      QueuedInterceptorsWrapper(
        onResponse: (e, handler) {
          return handler.next(e);
        },
        onError: (e, handler) {
          return handler.next(e);
        },
        onRequest: (options, handler) async {
          String? accessToken = await LocalStorage.get(AppConstants.token);
          
          if(accessToken != null) {
            options.headers.addAll({
              HttpHeaders.authorizationHeader: "Bearer $accessToken"
            });
          }

          return handler.next(options);
        },
      )
    )..transformer = DioTransformer();

    http.interceptors.addAll([
      PrettyDioLogger(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true
      )
    ]);
  }
}

  _parseAndDecode(String response) {
      return jsonDecode(response);
  }

  parseJson(String text) {
    return compute(_parseAndDecode, text);
  }