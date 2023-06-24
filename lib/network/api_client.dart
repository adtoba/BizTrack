import 'dart:io';

import 'package:biz_track/shared/utils/constants.dart';
import 'package:biz_track/shared/utils/storage.dart';
import 'package:dio/dio.dart';

class ApiClient {
  late Dio http;

  ApiClient() {
    http = Dio(
      BaseOptions(
        baseUrl: "127.0.0.1/api",
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
    );
  }
}