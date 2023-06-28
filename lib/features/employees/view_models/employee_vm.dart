import 'package:biz_track/features/employees/model/create_employee_response.dart';
import 'package:biz_track/features/employees/model/get_employee_response.dart';
import 'package:biz_track/network/api/employee_api.dart';
import 'package:biz_track/shared/utils/error_util.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class EmployeeViewModel extends ChangeNotifier {
  late EmployeeApi employeeApi;

  EmployeeViewModel() {
    employeeApi = EmployeeApi();
  }

  bool _busy = false;
  bool get busy => _busy;

  List<Employee> employees = [];

  Future<CreateEmployeeResponse?> createEmployee({
    String? name,
    String? phoneNumber,
    String? email,
    String? password,
    String? employeeRole,
    String? assignedBranch,
    String? address
  }) async {
    _busy = true;
    notifyListeners();

    try {
      final res = await employeeApi.createEmployee(
        name: name,
        password: password,
        phoneNumber: phoneNumber,
        email: email,
        employeeRole: employeeRole,
        assignedBranch: assignedBranch,
        address: address,
      );

      if(res != null) {
        await fetchEmployees();
        pop();
      }

      return res;

    } on DioException catch (e) {
      String message = ErrorUtil.error(e);
      ErrorUtil.showErrorSnackbar(message);
    } finally {
      _busy = false;
      notifyListeners();
    }
    return null;
  }

  Future<GetEmployeeResponse?> fetchEmployees() async {
    _busy = true;
    notifyListeners();

    try {
      final res = await employeeApi.fetchEmployees();

      employees = res?.employees ?? [];

      return res;

    } on DioException catch (e) {
      String message = ErrorUtil.error(e);
      ErrorUtil.showErrorSnackbar(message);
    } finally {
      _busy = false;
      notifyListeners();
    }
    return null;
  }

}