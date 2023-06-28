import 'package:biz_track/features/inventory/model/categories_response.dart';
import 'package:biz_track/features/inventory/model/products_response.dart';
import 'package:biz_track/network/api/inventory_api.dart';
import 'package:biz_track/shared/utils/error_util.dart';
import 'package:biz_track/shared/utils/navigator.dart';
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

  List<Category>? cashierCategories = [];

  void populateCategories() async {
    await getCategories();
    cashierCategories?.add(Category(
      name: "All Products",
      id: "",
    ));
    
    cashierCategories!.addAll(categories!);
    notifyListeners();
  }

  Future<void> createCategory({String? name}) async {
    _busy = true;
    notifyListeners();

    try {
      final res = await inventoryApi.createCategory(name: name);

      if(res != null) {
        cashierCategories?.clear();
        populateCategories();
        pop();
      }
      
    } on DioException catch (e){
      String error = ErrorUtil.error(e);
      ErrorUtil.showErrorSnackbar(error);
    } finally {
      _busy = false;
      notifyListeners();
    }
    return;
  }

  Future<Response?> createProduct({
    String? productName,
    String? sellingPrice,
    String? category,
    String? image,
    String? purchasePrice,
    String? branch,
    int? stockCount,
    String? barcode
  }) async {
    _busy = true;
    notifyListeners();

    try {
      final res = await inventoryApi.createProduct(
        name: productName,
        sellingPrice: sellingPrice,
        category: category,
        image: image,
        purchasePrice: purchasePrice,
        branch: branch,
        stockCount: stockCount,
        barcode: barcode,
      );

      if(res != null) {
        cashierCategories?.clear();
        populateCategories();
        await getProducts();
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

  Future<ProductsResponse?> getProductsByBranch({String? branchId}) async {
    _busy = true;
    notifyListeners();
    
    try {
      final res = await inventoryApi.getProductsByBranch(branchId: branchId);
      
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