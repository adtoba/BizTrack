import 'package:biz_track/features/customer/model/create_customer_response.dart';

class CustomersResponse {
  bool? status;
  String? message;
  List<Customer>? customers;

  CustomersResponse({this.status, this.message, this.customers});

  CustomersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      customers = <Customer>[];
      json['data'].forEach((v) {
        customers!.add(Customer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (customers != null) {
      data['data'] = customers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
