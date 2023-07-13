import 'package:collection/collection.dart';

import 'package:biz_track/features/cashier/views/successful_transaction_view.dart';
import 'package:biz_track/features/order/models/create_order_request.dart';
import 'package:biz_track/features/order/models/create_order_response.dart';
import 'package:biz_track/features/order/models/get_order_response.dart' as go;
import 'package:biz_track/network/api/order_api.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/utils/error_util.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderVm extends ChangeNotifier {
  late OrderApi orderApi;
  late ChangeNotifierProviderRef reference;

  OrderVm(ChangeNotifierProviderRef ref) {
    reference = ref;
    orderApi = OrderApi();
  }

  bool _busy = false;
  bool get busy => _busy;

  bool _getCashierOrdersBusy = false;
  bool get getCashierOrdersBusy => _getCashierOrdersBusy;

  final bool _getCustomerOrdersBusy = false;
  bool get getCustomerOrdersBusy => _getCustomerOrdersBusy;

  List<go.Data>? orders = [];
  Map<dynamic, dynamic> groupOrdersByDate = {};

  
  Future<CreateOrderResponse?> createOrder(CreateOrderRequest request) async {
    _busy = true;
    notifyListeners();

    try {
      final res = await orderApi.createOrder(request);
      
      if(res != null) {
        reference.watch(cartViewModel).clear();
        pushAndRemoveUntil(TransactionSuccessfulView(
          data: res
        ));
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

  Future<go.GetOrderResponse?> getOrders({bool? isEmployee = false, String? branchId}) async {
    _busy = true;
    notifyListeners();

    try {
      final res = isEmployee! 
        ? await orderApi.getOrdersByBranch(branchId:branchId)
        : await orderApi.getOrders();
        
      orders = res?.data ?? [];

      groupOrdersByDate = groupBy(orders!, (go.Data obj) => obj.createdAt!.split("T").first);
      notifyListeners();

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

  Future<Map<dynamic, dynamic>?> getOrdersByCashier({String? cashierId}) async {
    _getCashierOrdersBusy = true;
    notifyListeners();

    try {
      final res = await orderApi.getOrdersByCashier(cashierId: cashierId);
      var groupedOrders = groupBy(res!.data!, (go.Data obj) => obj.createdAt!.split("T").first);
      return groupedOrders;
    } on DioException catch (e){
      String error = ErrorUtil.error(e);
      ErrorUtil.showErrorSnackbar(error);
    } finally {
      _getCashierOrdersBusy = false;
      notifyListeners();
    }
    return null;
  }

  Future<Map<dynamic, dynamic>?> getOrdersByCustomer({String? customerId}) async {
    _getCashierOrdersBusy = true;
    notifyListeners();

    try {
      final res = await orderApi.getOrdersByCustomer(customerId: customerId);
      var groupedOrders = groupBy(res!.data!, (go.Data obj) => obj.createdAt!.split("T").first);
      return groupedOrders;
    } on DioException catch (e){
      String error = ErrorUtil.error(e);
      ErrorUtil.showErrorSnackbar(error);
    } finally {
      _getCashierOrdersBusy = false;
      notifyListeners();
    }
    return null;
  }

  Future<Map<dynamic, dynamic>?> getOrdersByBranch({String? branchId}) async {
    _getCashierOrdersBusy = true;
    notifyListeners();

    try {
      final res = await orderApi.getOrdersByBranch(branchId: branchId);
      var groupedOrders = groupBy(res!.data!, (go.Data obj) => obj.createdAt!.split("T").first);
      return groupedOrders;
    } on DioException catch (e){
      String error = ErrorUtil.error(e);
      ErrorUtil.showErrorSnackbar(error);
    } finally {
      _getCashierOrdersBusy = false;
      notifyListeners();
    }
    return null;
  }
}