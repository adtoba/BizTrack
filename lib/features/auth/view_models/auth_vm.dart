import 'package:biz_track/features/auth/model/login_response.dart';
import 'package:biz_track/features/auth/model/register_response.dart';
import 'package:biz_track/features/branch/models/get_branch_response.dart';
import 'package:biz_track/features/cashier/views/cashier_dashboard_view.dart';
import 'package:biz_track/network/api/auth_api.dart';
import 'package:biz_track/network/api/branch_api.dart';
import 'package:biz_track/shared/utils/constants.dart';
import 'package:biz_track/shared/utils/error_util.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthVm extends ChangeNotifier {
  late AuthApi authApi;
  late BranchApi branchApi;
  late ChangeNotifierProviderRef ref;

  AuthVm(ChangeNotifierProviderRef providerRef) {
    authApi = AuthApi();
    branchApi = BranchApi();
    ref = providerRef;
  }

  bool _busy = false;
  bool get busy => _busy;

  LoginResponse? loginResponse;
  Branch? userBranch;
  RegisterResponse? registerResponse;
  
  Future<LoginResponse?> login({String? email, String? password}) async {
    _busy = true;
    notifyListeners();

    try {
      final res = await authApi.login(email: email, password: password);

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
        userBranch = await branchApi.getBranchById(
          branchId: res.employee?.branch
        );
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
    String? businessName, 
    String? branchName,
    String? email, 
    String? password, 
    String? phone
  }) async {
    _busy = true;
    notifyListeners();

    try {
      final res = await authApi.register(
        businessName: businessName,
        branchName: branchName,
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