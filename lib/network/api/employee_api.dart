import 'package:biz_track/features/employees/model/create_employee_response.dart';
import 'package:biz_track/features/employees/model/get_employee_response.dart';
import 'package:biz_track/network/api_client.dart';
import 'package:biz_track/network/endpoints.dart';

class EmployeeApi extends ApiClient {
  Future<CreateEmployeeResponse?> createEmployee({
    String? name,
    String? phoneNumber,
    String? email,
    String? employeeRole,
    String? assignedBranch,
    String? address,
    String? password
  }) async {
    final res = await http.post(AppEndpoints.employee, data: {
      "name": name,
      "phoneNumber": phoneNumber,
      "email": email,
      "password": password,
      "role": employeeRole,
      "address": address,
      "branch": assignedBranch
    });

    return CreateEmployeeResponse.fromJson(res.data);
  }

  Future<GetEmployeeResponse?> fetchEmployees() async {
    final res = await http.get(AppEndpoints.employee);
    return GetEmployeeResponse.fromJson(res.data);
  }
}