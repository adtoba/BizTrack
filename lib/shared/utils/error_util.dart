import 'package:biz_track/main.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorUtil {
  static String error(DioException e) {
    String msg = "";

    if(e.type == DioExceptionType.receiveTimeout) {
      msg = "Your request timed out. Try again!!";
    }
    
    if(e.type == DioExceptionType.connectionTimeout) {
      msg = "Your request timed out. Try again!!";
    }

    if(e.type == DioExceptionType.badResponse) {
      if(e.response!.data.toString().contains("html")) {
        msg = "Oops, an error occured. Try again!!";
      } else if (e.response!.data is List){
        List data = e.response!.data;

        for(Map<String, dynamic> entry in data) {
          msg = entry["message"];
        }
      } else if(e.response?.data is Map) {
        msg = e.response?.data?["message"] ?? "Oops, an error occured. Try again!!";
      } else {
        msg = "Oops, an error occured. Try again!!";
      }
      
    }

    if(e.type == DioExceptionType.unknown) {
      msg = "Oops, an error occured. Try again!!";
    }

    return msg;
  }

  static void showErrorSnackbar(String message) {
    final config = SizeConfig();

    final snackBar = SnackBar(
      content: Text(message, style: TextStyle(fontSize: config.sp(14), color: Colors.white)),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 500),
    );

    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
  }
}