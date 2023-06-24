import 'package:biz_track/features/auth/model/login_response.dart';
import 'package:biz_track/features/auth/model/register_response.dart';
import 'package:biz_track/features/cashier/views/cashier_dashboard_view.dart';
import 'package:biz_track/network/api/auth_api.dart';
import 'package:biz_track/shared/utils/constants.dart';
import 'package:biz_track/shared/utils/error_util.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthVm extends ChangeNotifier {
  late AuthApi authApi;

  AuthVm() {
    authApi = AuthApi();
  }

  bool _busy = false;
  bool get busy => _busy;

  LoginResponse? loginResponse;
  RegisterResponse? registerResponse;
  
  Future<LoginResponse?> login({String? email, String? password}) async {
    _busy = true;
    notifyListeners();

    try {
      final res = await authApi.login(email: email, password: password);
      loginResponse = res;

      if(res != null) {
        loginResponse = res;
        await LocalStorage.put(AppConstants.token, res.authToken);
        pushAndRemoveUntil(const CashierDashboardView());
      }
      
      return res;
    } on DioException catch (e){
      String error = ErrorUtil.error(e);
      ErrorUtil.showErrorSnackbar(error);
    } finally {
      _busy = false;
      notifyListeners();
    }
    return null;
  }

  Future<LoginResponse?> employeeLogin({String? accessCode, String? password}) async {
    _busy = true;
    notifyListeners();

    try {
      final res = await authApi.employeeLogin(accessCode: accessCode, password: password);

      if(res != null) {
        loginResponse = res;
        await LocalStorage.put(AppConstants.token, res.authToken);
        pushAndRemoveUntil(const CashierDashboardView());
      }
    
      return res;
    } on DioException catch (e){
      String error = ErrorUtil.error(e);
      ErrorUtil.showErrorSnackbar(error);
    } finally {
      _busy = false;
      notifyListeners();
    }
    return null;
  }


  Future<RegisterResponse?> register({
    String? businessName, String? email, String? password, String? phone
  }) async {
    _busy = true;
    notifyListeners();

    try {
      final res = await authApi.register(
        businessName: businessName,
        email: email,
        password: password,
        phoneNumber: phone
      );

      if(res != null) {
        registerResponse = res;
        await login(
          email: email,
          password: password
        );
      }
    
      return res;
    } on DioException catch (e){
      String error = ErrorUtil.error(e);
      ErrorUtil.showErrorSnackbar(error);
    } finally {
      _busy = false;
      notifyListeners();
    }
    return null;
  }
}