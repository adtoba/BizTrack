import 'package:biz_track/features/customer/model/create_customer_response.dart';
import 'package:biz_track/features/customer/model/customers_response.dart';
import 'package:biz_track/network/api/customer_api.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/utils/error_util.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerVm extends ChangeNotifier {
  late CustomerApi customerApi;
  late ChangeNotifierProviderRef ref;

  CustomerVm(ChangeNotifierProviderRef providerRef) {
    customerApi = CustomerApi();
    ref = providerRef;
  }

  bool _busy = false;
  bool get busy => _busy;

  List<Customer>? customers = [];

  Future<CreateCustomerResponse?> createCustomer({
    String? name,
    String? phone,
    String? email,
    String? address,
    String? branch
  }) async {
    _busy = true;
    notifyListeners();

    try {
      final res = await customerApi.createCustomer(
        name: name,
        phoneNumber: phone,
        address: address,
        email: email,
        branch: branch
      );

      if(res != null) {
        var employee = ref.read(authViewModel).loginResponse?.employee;
        bool isEmployee = ref.read(authViewModel).loginResponse?.employee != null;

        await getCustomers(
          isEmployee: isEmployee,
          branchId: employee?.branch
        );

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

  Future<CustomersResponse?> getCustomers({bool? isEmployee, String? branchId}) async {
    _busy = true;
    notifyListeners();

    try {
      final res = isEmployee!
      ? await customerApi.getCustomersByBranch(branchId: branchId)
      : await customerApi.getCustomers();
      
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