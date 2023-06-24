import 'package:biz_track/features/inventory/model/categories_response.dart';
import 'package:biz_track/features/inventory/model/products_response.dart';
import 'package:biz_track/network/api_client.dart';
import 'package:biz_track/network/endpoints.dart';

class InventoryApi extends ApiClient {
  Future<ProductsResponse?> getProducts() async {
    final res = await http.get(AppEndpoints.product);
    return ProductsResponse.fromJson(res.data);
  }

  Future<ProductsResponse?> getProductsByCategory({String? categoryId}) async {
    final res = await http.get("${AppEndpoints.product}/category/$categoryId");
    return ProductsResponse.fromJson(res.data);
  }

  Future<CategoriesResponse?> getCategories() async {
    final res = await http.get(AppEndpoints.category);
    return CategoriesResponse.fromJson(res.data);
  }
}