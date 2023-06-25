import 'package:biz_track/features/customer/model/create_customer_response.dart';
import 'package:biz_track/features/customer/model/customers_response.dart';
import 'package:biz_track/network/api/customer_api.dart';
import 'package:biz_track/shared/utils/error_util.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CustomerVm extends ChangeNotifier {
  late CustomerApi customerApi;
  CustomerVm() {
    customerApi = CustomerApi();
  }

  bool _busy = false;
  bool get busy => _busy;

  List<Customer>? customers = [];

  Future<CreateCustomerResponse?> createCustomer({
    String? name,
    String? phone,
    String? email,
    String? address
  }) async {
    _busy = true;
    notifyListeners();

    try {
      final res = await customerApi.createCustomer(
        name: name,
        phoneNumber: phone,
        address: address,
        email: email
      );

      if(res != null) {
        await getCustomers();
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

  Future<CustomersResponse?> getCustomers() async {
    _busy = true;
    notifyListeners();

    try {
      final res = await customerApi.getCustomers();
      
      if(res != null) {
        customers = res.customers ?? [];
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
}