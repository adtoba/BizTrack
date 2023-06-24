import 'package:biz_track/features/inventory/model/categories_response.dart';
import 'package:biz_track/features/inventory/model/products_response.dart';
import 'package:biz_track/network/api/inventory_api.dart';
import 'package:biz_track/shared/utils/error_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class InventoryVm extends ChangeNotifier {
  late InventoryApi inventoryApi;

  InventoryVm() {
    inventoryApi = InventoryApi();
  }

  bool _busy = false;
  bool get busy => _busy;

  List<Category>? categories = [];

  List<Product>? productsByCategory = [];

  List<Product>? allProducts = [];

  Future<CategoriesResponse?> getCategories() async {
    _busy = true;
    notifyListeners();

    try {
      final res = await inventoryApi.getCategories();
      categories = res?.categories ?? [];
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

  Future<ProductsResponse?> getProducts() async {
    _busy = true;
    notifyListeners();

    try {
      final res = await inventoryApi.getProducts();
      allProducts = res?.products ?? [];
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

  Future<ProductsResponse?> getProductsByCategory({String? categoryId}) async {
    _busy = true;
    notifyListeners();
    
    try {
      final res = await inventoryApi.getProductsByCategory(categoryId: categoryId);
      productsByCategory = res?.products ?? [];
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