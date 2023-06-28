
import 'package:biz_track/features/employees/model/create_employee_response.dart';

class GetEmployeeResponse {
  bool? status;
  String? message;
  List<Employee>? employees;

  GetEmployeeResponse({this.status, this.message, this.employees});

  GetEmployeeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      employees = <Employee>[];
      json['data'].forEach((v) {
        employees!.add(Employee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (employees != null) {
      data['data'] = employees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}