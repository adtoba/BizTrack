import 'package:biz_track/features/order/models/create_order_request.dart';
import 'package:biz_track/features/order/models/create_order_response.dart';
import 'package:biz_track/features/order/models/get_order_response.dart';
import 'package:biz_track/network/api_client.dart';
import 'package:biz_track/network/endpoints.dart';

class OrderApi extends ApiClient {
  Future<CreateOrderResponse?> createOrder(CreateOrderRequest request) async {
    final res = await http.post(AppEndpoints.order, data: request.toJson());
    
    return CreateOrderResponse.fromJson(res.data);
  }

  Future<GetOrderResponse?> getOrders() async {
    final res = await http.get(AppEndpoints.order);
    return GetOrderResponse.fromJson(res.data);
  }

  
}