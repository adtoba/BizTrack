import 'package:biz_track/features/inventory/model/categories_response.dart';
import 'package:biz_track/features/inventory/model/products_response.dart';
import 'package:biz_track/network/api_client.dart';
import 'package:biz_track/network/endpoints.dart';
import 'package:dio/dio.dart';

class InventoryApi extends ApiClient {

  Future<Response?> createProduct({
    String? name,
    String? sellingPrice,
    String? category,
    String? image,
    String? purchasePrice,
    String? branch,
    int? stockCount,
    String? barcode
  }) async {
    final res = await http.post(AppEndpoints.product, data: {
      "name": name,
      "sellingPrice": sellingPrice,
      "category": category,
      "image": image,
      "purchasePrice": purchasePrice,
      "branch": branch,
      "stockCount": stockCount,
      "barCode": barcode
    });

    return res;
  }
  
  Future<ProductsResponse?> getProducts() async {
    final res = await http.get(AppEndpoints.product);
    return ProductsResponse.fromJson(res.data);
  }

  Future<ProductsResponse?> getProductsByCategory({String? categoryId}) async {
    final res = await http.get("${AppEndpoints.product}/category/$categoryId");
    return ProductsResponse.fromJson(res.data);
  }

  Future<ProductsResponse?> getProductsByBranch({String? branchId}) async {
    final res = await http.get("${AppEndpoints.product}/branch/$branchId");
    return ProductsResponse.fromJson(res.data);
  }

  Future<Response?> createCategory({String? name, String? branch}) async {
    final res = await http.post(AppEndpoints.category, data: {
      "name": name,
      "branch": branch
    });
    return res;
  }

  Future<CategoriesResponse?> getCategories() async {
    final res = await http.get(AppEndpoints.category);
    return CategoriesResponse.fromJson(res.data);
  }

  Future<CategoriesResponse?> getCategoriesByBranch({String? branchId}) async {
    final res = await http.get("${AppEndpoints.category}/branch/$branchId");
    return CategoriesResponse.fromJson(res.data);
  }

  Future<Category?> getCategoryById({String? categoryId}) async {
    final res = await http.get("${AppEndpoints.category}/$categoryId");
    return Category.fromJson(res.data['data']);
  }
}