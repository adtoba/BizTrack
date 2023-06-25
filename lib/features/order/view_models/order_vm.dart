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

  List<go.Data>? orders = [];

  
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

  Future<go.GetOrderResponse?> getOrders() async {
    _busy = true;
    notifyListeners();

    try {
      final res = await orderApi.getOrders();
      orders = res?.data ?? [];
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