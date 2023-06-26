import 'package:biz_track/features/branch/models/get_branch_response.dart';
import 'package:biz_track/network/api/branch_api.dart';
import 'package:biz_track/shared/utils/error_util.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class BranchVm extends ChangeNotifier {
  late BranchApi branchApi;

  BranchVm() {
    branchApi = BranchApi();
  }

  bool _busy = false;
  bool get busy => _busy;

  List<Branch?> branches = [];

  Future<void> createBranch({String? name}) async {
    _busy = true;
    notifyListeners();


    try {
      final res = await branchApi.createBranch(name: name);
      
      if (res != null) {
        await getBranches();
        pop();
      }
    } on DioException catch (e) {
      String message = ErrorUtil.error(e);
      ErrorUtil.showErrorSnackbar(message);
    } finally {
      _busy = false;
      notifyListeners();
    }
  }

  Future<void> getBranches() async {
    _busy = true;
    notifyListeners();

    try {
      final res = await branchApi.getBranches();

      if(res != null) {
        branches = res.branch!;
        notifyListeners();
      }

    } on DioException catch (e) {
      String message = ErrorUtil.error(e);
      ErrorUtil.showErrorSnackbar(message);
    } finally {
      _busy = false;
      notifyListeners();
    }
  }

}